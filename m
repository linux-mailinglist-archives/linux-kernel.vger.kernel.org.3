Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A2E4C0CEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbiBWHC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbiBWHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:02:26 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8962F36B6B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:01:59 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id c1so4344055pgk.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PWtkAfYu/9B+oPvGm4+64ny3S1ewos9AVUwAN6S/0ao=;
        b=j2n/wZoXzWWrjxmFte+sg2ojatUrb3DXEDYZH3Dd6gWkpBo+nX3FUH86bJczmZ5uKk
         FteFXLVHyg9QNx24ryD7cgLrs7Ti6yHIFaFmUCalBd9KES+zIJsPtA0YDmS+V7hAeedm
         g0M04sHpjeOxJDjddVNdgE2iauhR85wIwx1PamvovcMrXuh1JyclqrORbY0DqQkjtJ7S
         flM4A+MKmF1d48yxL0Es7UiQhp/NtjbBdVqJ1Fr1LN3/ui8I+g9os6Cr+jpNxaI8pihp
         mOaFCGYhxjB1VsXTvO7mOEeqSg10ksUXaFpB9aTK3CkgeiSPZ8jPyHMEcnQFjmvNOAod
         G1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PWtkAfYu/9B+oPvGm4+64ny3S1ewos9AVUwAN6S/0ao=;
        b=7K4ijtcBSHqC3ujiqIybaNhR0k0Zn2WF6Ys9H9QQ9m7z9iO6Bb27+gqhZVucM+GvCi
         h5d/05NGaFL76/NKe8z/tqwAluncE74mM49xFKwkce3SWKIJV8shBnWhNQNvy+I0TY1y
         23r/WUJSSMbbPQGgp8SfBOoGnIKTHRB4J+FTgmXXGSApzFPuHGta6at29FXMfnIOieoD
         IC+n7Y5uraU5uSqwMFs9fJGVpAPrKg0tDN6I7MXiBQRkOI56Gu5E4gUQXQx14Z/4a+a0
         NfFg4OsvVL2gVx2LosDzHhEabEEjfT8IEB/CTT9jrtNifuJjED/OOvMTJvqcruDT8oVP
         477g==
X-Gm-Message-State: AOAM533aMWL4Khe7EiJ9F6S2VOQXY6suL1SFZELc7MtpYbTsHryZ2722
        BBQfdgXZY9u/C+2l8VNJcT8=
X-Google-Smtp-Source: ABdhPJzuXQgtqbv19KKVidIx/JatoGPzmKzQSJKT5rzOBo2ipDu6kXoYMlGuIbUUxlrQnWQmfum5FQ==
X-Received: by 2002:a63:fe4a:0:b0:372:e047:bc20 with SMTP id x10-20020a63fe4a000000b00372e047bc20mr22270261pgj.339.1645599719054;
        Tue, 22 Feb 2022 23:01:59 -0800 (PST)
Received: from ubuntu.huawei.com ([119.3.119.21])
        by smtp.googlemail.com with ESMTPSA id c13sm20327446pfi.177.2022.02.22.23.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:01:58 -0800 (PST)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     jirislaby@kernel.org
Cc:     xiam0nd.tong@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Date:   Wed, 23 Feb 2022 15:01:52 +0800
Message-Id: <20220223070152.29159-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d83ae2d5-ac46-a3b8-ee9a-12615a48e9d9@kernel.org>
References: <d83ae2d5-ac46-a3b8-ee9a-12615a48e9d9@kernel.org>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 09:00:08 +0100, Jiri Slaby wrote:
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Already added in Patch v2, thanks!

Best regards,
--
Xiaomeng Tong
