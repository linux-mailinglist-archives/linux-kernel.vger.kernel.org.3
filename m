Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D85708F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiGKRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiGKRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C519C28E03
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657561065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3x/88KGK1UOzm+kY543e59CSvKjhxLTSG5BFabMAIIE=;
        b=KVm666gHuXYHKAr3JMhbcQbdLkZJb99LZNfB7A/mWXFxaSIrngblW4FVXYWxCNPdgDTKIe
        wcFMwdTgZVrlz90grAGGvhuXVinej49WS76VFKSEHLDURuC2zLrgFc6j2qzDmxPknvgIXc
        vh2I6aQL7jVKzdPZlDtegJIR88DEgxw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-uAY0fSbiORqtjpkRYzv9EQ-1; Mon, 11 Jul 2022 13:37:43 -0400
X-MC-Unique: uAY0fSbiORqtjpkRYzv9EQ-1
Received: by mail-wm1-f69.google.com with SMTP id t25-20020a7bc3d9000000b003a2ea772bd2so429390wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3x/88KGK1UOzm+kY543e59CSvKjhxLTSG5BFabMAIIE=;
        b=CpJdK/Mw9hrm1Hk7FfIIbMpxljShoqU9ES6PclPpS8JhGEKpTiRuz+LPL7rys5dpdW
         b/RoQwbfepWA9euyB6y4aqLG2NXGxKst02H0ebUMnz3QVdZ8OUEortUUYTgSPThPL+Og
         TvGiiqEEV2f070bCLxPr1kTUTNybrd1g4ma8WfWriik7zxgsornmVjshuAfw4ejD6MAj
         JXHfHS58B0Qdv5/c3XcBw+YpW3I6D1b253pF9HwtwPzngG8FvjMipiNF8bsQbFnFjc9i
         SiU18+ImBJPmHQsTllQOMkbTCv4jh7lA6klZ2Mgqp1pzyG2vOoZk4mYuCGvtyemK7S8H
         exhA==
X-Gm-Message-State: AJIora+JqBBCRNo49SU5nJaL2fys5g5TDinHgI/DGhwZsJD/VIN5WPV4
        HEakmYxdx780WI2ichSwZDQt7Sb5hpuU/7n1g8OVRq3dRo06Qx9ie2V9Kz9eD3v2dz/y19lwwMX
        KjjUiU+p702uhpIuuBFT/c1w=
X-Received: by 2002:a1c:7918:0:b0:3a2:e17c:cbfe with SMTP id l24-20020a1c7918000000b003a2e17ccbfemr14203661wme.80.1657561062719;
        Mon, 11 Jul 2022 10:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uC0kDstnO9C7PIIOHozWvLwOLpD+F/HXFSC5vHo/Y3VyAh8b+xOf2gwEgriKQpkkjzmP31Bw==
X-Received: by 2002:a1c:7918:0:b0:3a2:e17c:cbfe with SMTP id l24-20020a1c7918000000b003a2e17ccbfemr14203643wme.80.1657561062500;
        Mon, 11 Jul 2022 10:37:42 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b0021d9d13bf6csm4844219wrs.97.2022.07.11.10.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:37:41 -0700 (PDT)
Date:   Mon, 11 Jul 2022 18:37:40 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modules: Fix corruption of /proc/kallsyms
Message-ID: <20220711173740.6zyo7an5rbhxf4nq@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220701094403.3044-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220701094403.3044-1-adrian.hunter@intel.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-07-01 12:44 +0300, Adrian Hunter wrote:
> The commit 91fb02f31505 ("module: Move kallsyms support into a separate
> file") changed from using strlcpy() to using strscpy() which created a
> buffer overflow. That happened because:
>  1) an incorrect value was passed as the buffer length
>  2) strscpy() (unlike strlcpy()) may copy beyond the length of the
>     input string when copying word-by-word.
> The assumption was that because it was already known that the strings
> being copied would fit in the space available, it was not necessary
> to correctly set the buffer length.  strscpy() breaks that assumption
> because although it will not touch bytes beyond the given buffer length
> it may write bytes beyond the input string length when writing
> word-by-word.
> 
> The result of the buffer overflow is to corrupt the symbol type
> information that follows. e.g.
> 
>  $ sudo cat -v /proc/kallsyms | grep '\^' | head
>  ffffffffc0615000 ^@ rfcomm_session_get  [rfcomm]
>  ffffffffc061c060 ^@ session_list        [rfcomm]
>  ffffffffc06150d0 ^@ rfcomm_send_frame   [rfcomm]
>  ffffffffc0615130 ^@ rfcomm_make_uih     [rfcomm]
>  ffffffffc07ed58d ^@ bnep_exit   [bnep]
>  ffffffffc07ec000 ^@ bnep_rx_control     [bnep]
>  ffffffffc07ec1a0 ^@ bnep_session        [bnep]
>  ffffffffc07e7000 ^@ input_leds_event    [input_leds]
>  ffffffffc07e9000 ^@ input_leds_handler  [input_leds]
>  ffffffffc07e7010 ^@ input_leds_disconnect       [input_leds]
> 
> Notably, the null bytes (represented above by ^@) can confuse tools.
> 
> Fix by correcting the buffer length.
> 
> Fixes: 91fb02f31505 ("module: Move kallsyms support into a separate file")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  kernel/module/kallsyms.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Hi Adrian,

Thanks for following up!


Kind regards,
-- 
Aaron Tomlin

