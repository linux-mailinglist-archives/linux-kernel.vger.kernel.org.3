Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF751562A39
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 06:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbiGAEO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 00:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiGAEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 00:14:53 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1289A21E2F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:14:53 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so959249otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 21:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohGS/GHjNx6gKBxjpOLnl3kUH/TQygNHmQFNpt5O95s=;
        b=GuELxlwIpzpiKD2YPx5S9btLkqNl6v08gJXYXRJGHFF1f66CnWPQ+VhHnxgOwvZpUD
         SsiI7teOiWo6y3ihKRF/hSaI4nzEoB3dMDXnSONCa13yka7pK3SHf/LXJjiqUAJu6u97
         rjgo19RxR3a9kcnUjrqU/2/UvQYLgknm+nguYSvdiUnxcPEavtdVFkRoFiWzLziZigo2
         T8SdyW+XfKzqDJ5gLSWP0fGxGGfclbgvp0u0OeEUDrgqmoDthyzaO1bvFTw/484qfnBO
         J6FXiBr2WlOTUf3B6wVOwwao311dr866KSo6u+OemWstFMgdGU5Tf+coPHgJ0sOQfIiB
         Hdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohGS/GHjNx6gKBxjpOLnl3kUH/TQygNHmQFNpt5O95s=;
        b=pk1oZPUba/kwarcPp25ThYdiYz579QrD2F/g98/FsNm7tEuFU5v9kzwLyc/32L9905
         yXxGJpYM/hezWmLdSmdAlAWGn9dTn5QSwu3i2FQJfyTVFsN+6SI4OenK+qJjgEqniMEg
         b6tzbPJKEKFjZQ1BT+s5A/HHvL8UaV0ckCuR+g4GDmZZOIaulFDkoxVYU/MDeYoZq0N2
         n9jN4R27YkKl9EKE6B51DG7h29j3CT7LPgF0TTiTUGKl6plKPJySjs/F+UN8ys0MfEud
         h2mRh8fea65Z1T0SjXZwqWYIsZYQXemR8A0S6IRGfImpEkcr/g3EhgSB1myrzjimKfjG
         +8jQ==
X-Gm-Message-State: AJIora+CGNZB4ZJWF6cs7c4eeMSgALHXbDbTiBfDOvLgCPxsD2gMjs7i
        P2vwGFj2QvD6FN8n1E+Y3cAUKMuwdv5Ol0E8wqVluQ==
X-Google-Smtp-Source: AGRyM1uVQkyvpZqWDwzmoKsksd5X4YjrjaWxlBJlYHpBkAj0z5nN/XbtMv/wWV3AOCs3/mFOVaWht/cbshz/KM0rpXI=
X-Received: by 2002:a05:6830:14:b0:616:dcbd:e53e with SMTP id
 c20-20020a056830001400b00616dcbde53emr5370409otp.267.1656648891911; Thu, 30
 Jun 2022 21:14:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-19-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-19-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Jun 2022 21:14:40 -0700
Message-ID: <CALMp9eRhxvquDMn3ROUqdNL4bG769eG+ZJ4o3t8rwne8pkKbiw@mail.gmail.com>
Subject: Re: [PATCH v2 18/28] KVM: VMX: Move CPU_BASED_CR8_{LOAD,STORE}_EXITING
 filtering out of setup_vmcs_config()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, move CPU_BASED_CR8_{LOAD,STORE}_EXITING filtering
> to vmx_exec_control().
>
> No functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
