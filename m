Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC7854B0E2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbiFNMft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244785AbiFNMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:35:13 -0400
Received: from es400ra01.iit.it (mx.iit.it [90.147.26.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399FC4D624;
        Tue, 14 Jun 2022 05:32:08 -0700 (PDT)
Received: from es400ra01.iit.it (127.0.0.1) id hl1vse0171sj; Tue, 14 Jun 2022 11:11:25 +0200 (envelope-from <prvs=1164ae077f=Andrea.Merello@iit.it>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iit.it;
        s=mx; i=@iit.it; h=Received:Received:Received:From:To:CC:Subject:
        Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
        Accept-Language:Content-Language:Content-Type:
        Content-Transfer-Encoding:MIME-Version; bh=uCV9D7UJ7l2/i8EBZAvP7
        xnjKZ4fGqslAk6WCTBRIKg=; b=NLFz1GZJ86IPOyj/Pc2KDZh1Z/C7Hu8jH3mJc
        /0Zc9RNlSXoZEApSP6qTPvpgj9Az72df4Fpb0PGGUXZZvQIp3oY6AQ1Wp6gGPgkk
        Ev+PUxPMc251LlACRfOLicc7mD2DfNxlHUO5EY1js7ZM3HVcBNam60psyG6gxQTy
        rBMc0Q=
Received: from mail.iit.it ([10.255.8.186])
        by es400ra01.iit.it ([172.31.0.241]) (SonicWall 10.0.16.7295)
        with ESMTPS (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256)
        id o202206140911250186297-11; Tue, 14 Jun 2022 11:11:25 +0200
Received: from iitmxwge020.iit.local (10.255.8.186) by iitmxwge020.iit.local
 (10.255.8.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.17; Tue, 14 Jun
 2022 11:11:24 +0200
Received: from iitmxwge020.iit.local ([fe80::f175:7e44:343:dc1b]) by
 iitmxwge020.iit.local ([fe80::f175:7e44:343:dc1b%4]) with mapi id
 15.01.2375.017; Tue, 14 Jun 2022 11:11:24 +0200
From:   Andrea Merello <Andrea.Merello@iit.it>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
Subject: Re: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Thread-Topic: [v6 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
Thread-Index: AQHYfx3utmV3pJ3K2U+b/YbA0CL4iq1NadiAgAExt3k=
Date:   Tue, 14 Jun 2022 09:11:24 +0000
Message-ID: <164f663acbba481a8ea8f45f185aaf83@iit.it>
References: <20220613120534.36991-1-andrea.merello@iit.it>
 <20220613120534.36991-9-andrea.merello@iit.it>,<CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com>
In-Reply-To: <CAHp75Vdh8kAH6540xCwzFh5uf=QMVTHC42a8pOgvkpObzjfD+w@mail.gmail.com>
Accept-Language: en-US, it-IT
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [90.147.26.235]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mlf-DSE-Version: 6874
X-Mlf-Rules-Version: s20220519150137; ds20200715013501;
        di20220613172248; ri20160318003319; fs20220613172626
X-Mlf-Smartnet-Version: 20210917223710
X-Mlf-Envelope-From: Andrea.Merello@iit.it
X-Mlf-Version: 10.0.16.7295
X-Mlf-License: BSV_C_AP_T_R
X-Mlf-UniqueId: o202206140911250186297
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few inline comments, OK for the rest.

>...
>
>> +                                /* G:   2,    4,    8,    16 */
>
>Indentation of this comment is a bit off.
>
>> +static int bno055_acc_range_vals[] =3D {1962, 3924, 7848, 15696};
>
>Perhaps split this to 4 lines and put the comment on top of the third line=
?

Not sure what you mean here, sorry. May you elaborate or provide an example=
, please?

>...
>
>> +static void bno055_debugfs_init(struct iio_dev *iio_dev)
>> +{
>> +       struct bno055_priv *priv =3D iio_priv(iio_dev);
>> +
>> +       priv->debugfs =3D debugfs_create_file("firmware_version", 0400,
>> +                                           iio_get_debugfs_dentry(iio_d=
ev),
>> +                                           priv, &bno055_fw_version_ops=
);
>
>> +       devm_add_action_or_reset(priv->dev, bno055_debugfs_remove, priv-=
>debugfs);
>
>Shouldn't we report the potential error here? It's not directly
>related to debugfs, but something which is not directly related.

The error eventually comes out from something that has nothing to do with d=
ebugs per se (i.e. the devm stuff), but it will only affect debugfs indeed.

Assuming that we don't want to make the whole driver fail in case debugfs s=
tuff fails (see last part of the comment above debugfs_create_file() implem=
entation), and given that the devm_add_action_or_reset(), should indeed "re=
set" in case of failure (i.e. we should be in a clean situation anyway), I =
would say it should be OK not to propagate the error and let things go on.

However we can add a dev_warn() to report what happened.


