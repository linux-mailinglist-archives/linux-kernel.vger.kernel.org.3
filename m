Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C976F4CAB0F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243620AbiCBRC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243658AbiCBRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7836ACB668
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646240528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rd6aip8xWGW26J5sRuqwhGdbjTj2rP5btIv5QWD2Mkg=;
        b=Z0VZ7Uto7rBs8SPhQES99Ocod+3Lne5K5mT/Tz6t0a+zPrreOL1NnQcmMdvfJNwNAeqCfp
        zF8v6YMLORyzQRTtVToQ3zS2TkkNaoKnZ6jgrvv/D9ATXGs/LibiAWB5vzAVL9hKRCCJFh
        Iie58t17wnEvEGroFJ340mkG52PrdYc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-330-BkQuOA6HM22aYNlSy-30dg-1; Wed, 02 Mar 2022 12:02:07 -0500
X-MC-Unique: BkQuOA6HM22aYNlSy-30dg-1
Received: by mail-wr1-f70.google.com with SMTP id ba15-20020a0560001c0f00b001f01822f821so862309wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rd6aip8xWGW26J5sRuqwhGdbjTj2rP5btIv5QWD2Mkg=;
        b=OZM/Kd5OVNg5o47b9Zx/JxENAzQQ7HSbhtWXcixdnvPU2tPy7opIkV//kpJ+c8SeYL
         6UjoHDpHHq4JlnAvYvsfhu/ZTt9trrgmcebbemg1hBMKav1sSUpfFQ7VKmjbWgz8UZQn
         sN91WeeifFA/F80thvrrTpnVE+6hPYnwluB+3MPwsFn6/yZDNKkKLYBpvyROLdCNNJvg
         BtC8oq9vw4oYFLE16aGNXxsEWKRYMezNI4o8C2tr3cy+vKPtP781IXt3Jp0hy6SOrXUG
         HtGAFDuZmDQaFbs4RrDiSXyp/Xj4IWcAdDDwu28haaeGdt6iFtqQVeJw+jz9hKs9tDWm
         j1pg==
X-Gm-Message-State: AOAM533U/+8oFTERmhT6a4mYg1TduwmAceS/cFOqCZYFeliuVSzeDGbn
        Vx6mTPPwBALiDOXC9XcfRMPV0a27p36GI30JtOfRIL5s7+DP9MDby8yEhMMji1UVCkYhDHPyIWe
        IIFyfjV7CKXTtVfwnPdujdmo=
X-Received: by 2002:a5d:654e:0:b0:1f0:1a18:166c with SMTP id z14-20020a5d654e000000b001f01a18166cmr5974852wrv.28.1646240524697;
        Wed, 02 Mar 2022 09:02:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxMzcpyzOGWIlpDjbhmT42tQ9LNvh9Wvh8XJd5z++9TTyMj7rOAC+j4Bhyrzp6SUNSrhq6qw==
X-Received: by 2002:a5d:654e:0:b0:1f0:1a18:166c with SMTP id z14-20020a5d654e000000b001f01a18166cmr5974831wrv.28.1646240524459;
        Wed, 02 Mar 2022 09:02:04 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm6443457wmj.5.2022.03.02.09.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:02:03 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:02:02 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     pmladek@suse.com
Cc:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, cl@linux.com,
        mbenes@suse.cz, akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        atomlin@atomlin.com
Subject: Re: [PATCH v9 10/14] module: kallsyms: Fix suspicious rcu usage
Message-ID: <20220302170202.lsz2mqmll6gshuwr@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-11-atomlin@redhat.com>
 <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220301165229.5pwxyhxonbw5za3i@ava.usersys.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-03-01 16:52 +0000, Aaron Tomlin wrote:
> Petr,
> 
> Any concerns?
> 
> Unfortunately, I didn't make enough time to test.

Petr,

$ sudo ./test-livepatch.sh
[sudo] password for atomlin:
TEST: basic function patching ... ok
TEST: multiple livepatches ... ok
TEST: atomic replace livepatch ... ok

 - dmesg output excerpt

[  209.354909] ===== TEST: basic function patching =====
[  209.435376] % modprobe test_klp_livepatch
[  209.467226] test_klp_livepatch: tainting kernel with TAINT_LIVEPATCH
[  209.539749] livepatch: enabling patch 'test_klp_livepatch'
[  209.539785] livepatch: 'test_klp_livepatch': initializing patching transition
[  209.543671] livepatch: 'test_klp_livepatch': starting patching transition
[  210.716486] livepatch: 'test_klp_livepatch': completing patching transition
[  210.717405] livepatch: 'test_klp_livepatch': patching complete
[  210.766777] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
[  210.767446] livepatch: 'test_klp_livepatch': initializing unpatching transition
[  210.767548] livepatch: 'test_klp_livepatch': starting unpatching transition
[  211.739802] livepatch: 'test_klp_livepatch': completing unpatching transition
[  211.778846] livepatch: 'test_klp_livepatch': unpatching complete
[  211.862102] % rmmod test_klp_livepatch


Kind regards,

-- 
Aaron Tomlin

