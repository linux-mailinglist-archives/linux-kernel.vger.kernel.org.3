Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE3580337
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiGYQ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiGYQ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FEEFDEB9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658768270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zUTQcsRLeLjivibUTZmQzNSPdRIp0K6U7bQi13E1Qj8=;
        b=Fuv1MDgui55xaEk1+IKmHxvIVrs2WZw3fbxlI140G3FxByiFqbPcuy7Y+kxkgOb2L1nkHp
        6jh6X5FP8cIHE74jcMHxfRQwxubEZNyUB/zyimbVkVdSbtikuK4kw5SqSfnCAUazSzKHq3
        xTZcHzE8X5mei2ycCwpn67lYRvkuHOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-vvzqA9c5NwKGtlQgC_DWNw-1; Mon, 25 Jul 2022 12:57:49 -0400
X-MC-Unique: vvzqA9c5NwKGtlQgC_DWNw-1
Received: by mail-wm1-f69.google.com with SMTP id z11-20020a05600c0a0b00b003a043991610so4294917wmp.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUTQcsRLeLjivibUTZmQzNSPdRIp0K6U7bQi13E1Qj8=;
        b=NTSWbn9GSufEkWYBAfHXlFmE6p3CaFXq/YsrCMHDlrWKlB40bCRIZy8iMvglUL/ck4
         1CfbA2JBy8mLPUyh5sBVWAnNxuDWohgMpvI5qDSYczfTToYR7T4ter4GD2p2vSfwOj1U
         Lj9xJrtGr36LQ17EjhIyyvAkKfEICiaGF2OoEVtUZNvCBDg2kESWjE+xfPWBJLbq3MGx
         MFQg05EujFGVdKLwX5imYy5ev3X5FurHE1jnkvNpOEKRkeDxm+JFlk9pw0n9mry4sMW3
         YE5hxxCtlbqEmvlIeNEwOBJAHKTcgG2xlbj3Q3WL0HhdIu/uRJ1G64C+n2z68htJ9OJA
         3Wxg==
X-Gm-Message-State: AJIora/mKy15S12PqYBiCpxfvdhzW4ipI1mXrdBsl3w0XejEKA/x4I0d
        l6EkZIC3zi4HFjCXBh7bShv0pwUw4c3n/T19I/R0UCFNbjIHxRtQH8stRmNSWIOqDq7HnngDy2M
        FXAUWZjt27UeA0K/XWMq3x547
X-Received: by 2002:a5d:52c4:0:b0:21e:428a:912b with SMTP id r4-20020a5d52c4000000b0021e428a912bmr8284281wrv.395.1658768268029;
        Mon, 25 Jul 2022 09:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vRXdoRgIcwEQFMM1Bbckaj4HHI9azZqFwkj6SGqynNPbemdAV9RYTJlHMOrSfp468++8vnzA==
X-Received: by 2002:a5d:52c4:0:b0:21e:428a:912b with SMTP id r4-20020a5d52c4000000b0021e428a912bmr8284265wrv.395.1658768267774;
        Mon, 25 Jul 2022 09:57:47 -0700 (PDT)
Received: from pc-4.home (2a01cb058918ce00dd1a5a4f9908f2d5.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:dd1a:5a4f:9908:f2d5])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0039c96b97359sm16080728wmq.37.2022.07.25.09.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:57:47 -0700 (PDT)
Date:   Mon, 25 Jul 2022 18:57:45 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Matthias May <matthias.may@westermo.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, nicolas.dichtel@6wind.com,
        eyal.birger@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 net-next] geneve: fix TOS inheriting
Message-ID: <20220725165745.GC18808@pc-4.home>
References: <20220724003741.57816-1-matthias.may@westermo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724003741.57816-1-matthias.may@westermo.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 02:37:39AM +0200, Matthias May wrote:
> Is there any reason why the flowlabel should be restricted to these
> 3 bits?

It's a bug, likely a copy/paste mistake.

> The patch simply removes the usage of this macro, but i don't
> know if there was a specific intention behind that.

RT_TOS() is an old macro used to interprete IPv4 TOS as described in
the obsolete RFC 1349. It's conceptually wrong to use it even in IPv4
code, although, given the current state of the code, most of the
existing calls have no consequence.

But using RT_TOS() in IPv6 code is always a bug: IPv6 never had a "TOS"
field to be interpreted the RFC 1349 way. There's no historical
compatibility to worry about.

