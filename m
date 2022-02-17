Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2153B4BA44F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiBQPZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:25:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbiBQPZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:25:38 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11E62B048B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:25:24 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id bt13so13809510ybb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQP46pb+DPsuzuoL3BGGcclWodDFs0G/3Es7HjdxUCo=;
        b=cMfVnVTpouxlUm+jaYnytrgpG4TUi9DLUb+yI8qFyskWkAnXv+M6au1/maKPGNtmO8
         GcaWRklihf6L8yh393NfKIPLun4OQl9mYY1jRZzl8G0dxaxR37h911mKIPqAbIPKz/v+
         6NHpGj21rf8gWajcLnxmDL3+gi1yzfX/0r5GsyQNm0G3ZDxFDCyEhP0ciU9iVcvUP+7O
         O/wtUSIJGcfT+Ts4VAKp3Aryl+D1ZEsXMiVhErXbkzytbGDcWRcL5hG4Z9uexhoyPRc9
         FH+/+Hlyt8N+opqaLI0HBwUBgEOZ3cX4lZaeTqsxqLys+lkPUrmtmR1F+dIq1tL4rZGb
         Yk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQP46pb+DPsuzuoL3BGGcclWodDFs0G/3Es7HjdxUCo=;
        b=xKoZ7uQz2WNeDgQFlZ9NRwZKvTVjSiOER4EEGgRYB6Rry7BazRQJc0egt+iDmkH2Hr
         7zAA8VTGiN8XjwArmaOn1QTW7QwkcW9W9A4ZyhSWH39W6EMc+g2B3MpqB2WH68cqmd5j
         PfaciHh5bJEMb612oFpB6KBtM/89EnhQWASABe5PwXFcdh9qOcl6vg7KiX7yE0MLx4N7
         pVPmVi3ZFB/ngn97EDkNNYgMh2agfwABQW63xeIEpia1oDas3SWIAEqbFjqYF6EgWOXH
         YDhnhvuyCO2kyaYgxR0VCzxoXODaPkqdk97knDGPyFOgL7P5MIbs58tmutP+r/P5G/fK
         M2KQ==
X-Gm-Message-State: AOAM530tGCRowsAQ0EANLLDBnI1+4y9qTUMJ5vjamkSFPl8gTO2Ra1fq
        /q2f6wlvU3XH4YUTTNcfqfI0JlgYcLtJxl+g95HJaA==
X-Google-Smtp-Source: ABdhPJyRTktloudhS4FEJQohjippofIbUD6G2axzL1w3brFImkJhKhl9UwTpCXgO94Cef378CE+W+AWSzkPuQK6S+cM=
X-Received: by 2002:a5b:7c6:0:b0:60b:a0ce:19b with SMTP id t6-20020a5b07c6000000b0060ba0ce019bmr2751275ybq.407.1645111523530;
 Thu, 17 Feb 2022 07:25:23 -0800 (PST)
MIME-Version: 1.0
References: <20220217140441.1218045-1-andrzej.hajda@intel.com>
 <20220217140441.1218045-3-andrzej.hajda@intel.com> <CANn89iKgzztLA3y6V+vw3RiyoScC3K=1Z1_gajj8H56wGWDw6A@mail.gmail.com>
In-Reply-To: <CANn89iKgzztLA3y6V+vw3RiyoScC3K=1Z1_gajj8H56wGWDw6A@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Feb 2022 07:25:12 -0800
Message-ID: <CANn89iKsP=fO9va0pP9VrruXMKGnRhf9geGawDciTMdz3fOKhg@mail.gmail.com>
Subject: Re: [PATCH 2/9] lib/ref_tracker: compact stacktraces before printing
To:     Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        netdev <netdev@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Chris Wilson <chris.p.wilson@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 7:23 AM Eric Dumazet <edumazet@google.com> wrote:


> Then, iterating the list and update the array (that you can keep
> sorted by ->stack_handle)

The 'sorted' part might be unnecessary, if all callers keep
@display_limits small enough.
