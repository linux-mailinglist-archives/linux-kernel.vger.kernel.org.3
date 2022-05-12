Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3573752585B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359508AbiELXcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357948AbiELXca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:32:30 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9D5606E6
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:32:28 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id s12-20020a0568301e0c00b00605f30530c2so3812251otr.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTUkwCFl4eQnWHOmjCkOZ+MxC51lVa04QGhlnVFdjr0=;
        b=KCrUnBzZw0FbOC+bEY7DfMZabUIkT+ejInGoZJeN7Z04sWegXELod3KusB2HhalIi5
         moYjXXYdISshVNhloFqTXBAiiT8l1Lt/qb/MDoDLeRzxOQp6HXpIrH0CmCrG2Rk3QFUa
         D+SRhwry0qQ4fATRknA4vw+r8Xgo7LZzKKZ1XZhAgJ2F7TEBBb5gMElHh25rAwzNlH0d
         GqjCG59VaExNP8G1h5SgoulEBKCV/nWa3vnP3yagHJrYA2//ctSBMjCm529dxDY7MrrG
         aE8JDRNAd69wVZ4eoNGdu6jmJgXq/Znwz0D6cveCP4PIfKzxkWrKdfcTqKxZQTcSOtme
         DAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTUkwCFl4eQnWHOmjCkOZ+MxC51lVa04QGhlnVFdjr0=;
        b=1gwBc7KHPRxlp24yZq+zmmDyj29ouWn+MDQpUn0s77I+w61eQG8W1qDytRCSS1mfFM
         UfvVMP0K0kjAf16OkitlQcLyRyL4OMnQdboc6W1GxAT76DrUDAZZzQI3OmOew+pGlnjq
         h/V76UUoP6wA2G3A2kQxAeHwFbuJQRX/UJLAnOYpOX4u5zo0Ckvl42voIfxT9GkEqNSn
         HpWWfWlsJ9HFm5MetDLo703TeHZctyXP0I0Z8Uud7XKXMQ9GJyePh/MOuIlEtNkQ4bij
         vPNcb0XCl4WT1lVSzuZGcrzkcQsIJ9dX+scDFlydPMbpGMZs/NmznOFW+RBd5kWW8Bh/
         0fBQ==
X-Gm-Message-State: AOAM533c6y8wI1i97C7Rn5FRwSAvA5q4Slzj5NWDBcN5sPWRJGBeinzK
        yvP8AZlTGLeT/8SlPbN1hE6U2mMbQNTX6kcKiYk3Kg==
X-Google-Smtp-Source: ABdhPJymXYbisqYMcq1fGyKKmDxQzIG71HgmBEDe2A8NT63b1QV/sdpApHnFRtTyoDh1hbCmsjh6HHMT6FeJG8um0yE=
X-Received: by 2002:a05:6830:1c65:b0:606:3cc:862 with SMTP id
 s5-20020a0568301c6500b0060603cc0862mr886983otg.75.1652398347631; Thu, 12 May
 2022 16:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220512222716.4112548-1-seanjc@google.com> <20220512222716.4112548-4-seanjc@google.com>
In-Reply-To: <20220512222716.4112548-4-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 12 May 2022 16:32:16 -0700
Message-ID: <CALMp9eRZySh=rLQNUx6fbxDa-6G-vS837tBi=J3HZ9ePTVLa-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM: x86: Add helpers to identify CTL and STATUS MCi MSRs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jue Wang <juew@google.com>
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

On Thu, May 12, 2022 at 3:27 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Add helpers to identify CTL (control) and STATUS MCi MSR types instead of
> open coding the checks using the offset.  Using the offset is perfectly
> safe, but unintuitive, as understanding what the code does requires
> knowing that the offset calcuation will not affect the lower three bits.
>
> Opportunistically comment the STATUS logic to save readers a trip to
> Intel's SDM or AMD's APM to understand the "data != 0" check.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
