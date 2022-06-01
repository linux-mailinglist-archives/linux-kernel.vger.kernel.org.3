Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050AF53A281
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352034AbiFAK0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344810AbiFAK0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:26:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD9326A06B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654079194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oayruzY1g/yMYaOhPxizJIHK23v1X//M7rw4aeHmAXs=;
        b=F+s0qEjpfo4mrprhWOse/3NyW+IGGy2G9k8LRzbfgkiVoNwphT8FguSJngl/UrTii4CSsk
        JV3LMCaLClEGj0JW+9Vhmfr3wR+wc4ByNEdBLF4SSZD765vMpGHZvgdGXTjxlWU44PNdFe
        SncXXpOfl5bBCDQ0Dw2OJulXLdXmFj8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-NWstEUU4Md6Sc7Qaew_4mQ-1; Wed, 01 Jun 2022 06:26:33 -0400
X-MC-Unique: NWstEUU4Md6Sc7Qaew_4mQ-1
Received: by mail-ed1-f69.google.com with SMTP id q29-20020a056402249d00b0042d90fd98deso953791eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 03:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oayruzY1g/yMYaOhPxizJIHK23v1X//M7rw4aeHmAXs=;
        b=thSBftbP85Ii4o9HDxUdvGmR8/Thcl8G8QWjf5ugZEV85AnoGjb5jUwI9g+bhtyK7s
         qSOeH7LStwhthnOElDR9vqq/LcgjUWX+demlZNny6pHxEGFOVFPeGTGZ6NELX2k+usOk
         rxWCu9aDOAqxxH+xJOBQzlqmuDtDxeS1SZqhmLcHlYKSlD/lMndUWyRhrRgPp9Rm069c
         XBJru70W2+BA4g6Zn12mijORfZRC79nn2hfaUdj9QUFbP+uUxF7E+JsYDhWkcQ6Wmzjw
         +Efhj3CSKi7WzUp7OvbPdAWXS9tuy7HD7WhG3C1KlEZALrxeXqSrqRxhD4eKPJokV6yl
         LAgQ==
X-Gm-Message-State: AOAM5326uhfncWJdIVQN8zupY32RLBRg1tDjN3CgHMek7BMV5GakryNh
        u1K/YqVYkFYYMektVTSbk79uvIH5S3j0X8I1cmaK4IXRMku8heZMEc9hB5zASYv/8TX/W1oOL0S
        XOuZt62Ebfr+7RXD6WRN41N3O
X-Received: by 2002:a17:907:3ea0:b0:6ff:7d7a:480d with SMTP id hs32-20020a1709073ea000b006ff7d7a480dmr12363284ejc.750.1654079191110;
        Wed, 01 Jun 2022 03:26:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykWnDpg5av86qrft7TWzZN23lyKHi+FN9xzjJ7M/SxQ+5JHcpYM6HweEsgZtSiptAKLBfYWg==
X-Received: by 2002:a17:907:3ea0:b0:6ff:7d7a:480d with SMTP id hs32-20020a1709073ea000b006ff7d7a480dmr12363252ejc.750.1654079190735;
        Wed, 01 Jun 2022 03:26:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id me3-20020a170906aec300b006ff01fbb7ccsm545676ejb.40.2022.06.01.03.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 03:26:29 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AE4574051C9; Wed,  1 Jun 2022 12:26:27 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: kernel/bpf/devmap.c:1030:40: sparse: sparse: cast removes
 address space '__rcu' of expression
In-Reply-To: <20220601003834.ilvx2pik672yxuxt@mail>
References: <202205222029.xpW3PM1y-lkp@intel.com> <87y1yspmmh.fsf@toke.dk>
 <20220601003834.ilvx2pik672yxuxt@mail>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 01 Jun 2022 12:26:27 +0200
Message-ID: <87h7547k8c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Mon, May 23, 2022 at 12:30:14PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> kernel test robot <lkp@intel.com> writes:
>>=20
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
.git master
>> > head:   eaea45fc0e7b6ae439526b4a41d91230c8517336
>> > commit: 782347b6bcad07ddb574422e01e22c92e05928c8 xdp: Add proper __rcu=
 annotations to redirect map entries
>> > date:   11 months ago
>> > config: ia64-randconfig-s031-20220522 (https://download.01.org/0day-ci=
/archive/20220522/202205222029.xpW3PM1y-lkp@intel.com/config)
>> > compiler: ia64-linux-gcc (GCC) 11.3.0
>>=20
>> Hmm, so this is ia64-only? Some kind of macro breakage? Paul, any ideas?
>
> Hi,
>
> It's surely IA64's cmpxchg() which contains lines like:
> 	_r_ =3D ia64_cmpxchg8_##sem((__u64 *) ptr, new, _o_);=20

Oh, right. Hmm, well, if the cmpxchg does an internal cast that
complicates things a bit. My immediate thought was to move the
unrcu_pointer() inside the calls to cmpxchg(), like:

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 980f8928e977..3b6dc6d34177 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -1098,7 +1098,7 @@ static int dev_map_notification(struct notifier_block=
 *notifier,
                                dev =3D rcu_dereference(dtab->netdev_map[i]=
);
                                if (!dev || netdev !=3D dev->dev)
                                        continue;
-                               odev =3D unrcu_pointer(cmpxchg(&dtab->netde=
v_map[i], RCU_INITIALIZER(dev), NULL));
+                               odev =3D cmpxchg(unrcu_pointer(&dtab->netde=
v_map[i]), dev, NULL);
                                if (dev =3D=3D odev)
                                        call_rcu(&dev->rcu,
                                                 __dev_map_entry_free);


But that seems to confuse sparse because these are ptr-to-ptr
constructs:

kernel/bpf/devmap.c:1101:40: error: incompatible types in comparison expres=
sion (different address spaces):
kernel/bpf/devmap.c:1101:40:    struct bpf_dtab_netdev [noderef] __rcu *[no=
deref] __rcu *
kernel/bpf/devmap.c:1101:40:    struct bpf_dtab_netdev [noderef] __rcu **
kernel/bpf/devmap.c:1101:40: error: incompatible types in comparison expres=
sion (different address spaces):
kernel/bpf/devmap.c:1101:40:    struct bpf_dtab_netdev [noderef] __rcu *[no=
deref] __rcu *
kernel/bpf/devmap.c:1101:40:    struct bpf_dtab_netdev [noderef] __rcu **

which I'm not sure how to fix. And not really sure if it's the
semantically right thing to do either in this case...

-Toke

