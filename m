Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6775A0881
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 07:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbiHYFlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 01:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiHYFl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 01:41:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841F80023
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 22:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8MV0otBctW2ubSxLT2j8ypvQYESRIUmdseHpZoV384W8hw4Jl8IXxCHYcPnQfe4migz9YTYP5AJNWDq3LNaSAA3S08C+14p88ebh8XzJ5E8ye+ZVU79f2/NCvATrfMm3br+6tn+GvGUqgaZfQlGbcEOM7bki4o1BcLQfIWfw1bqGiYPG6UKMDHe3jZ4qKgYmHgNHVGGhanXXcdvICEDF7p1ge8ChUOTbBk3/y/2zvW+T/gehZPJ1gkpJiIqbmcSSczu0tDE9y8vaKYGmx8aYgZkgA9+fttU97JIGDvUTVij5F4DdKZAqYnUUHmfl/nRZ0yQevVTySgxm6xWiYzk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtmN7w/w2jcIwNEOJxiBZL3Yl5qEkpsh8g8D36vGDxE=;
 b=cFb1W0Xu526v+bEqg0B6qA5mQyad0NYQ7sOko7C6Em11m5Ff0xLOWRi/iuuCZa2enghFK+JqgU/qdypQJlpU2Bm9fE0rPOiwrgWOmvwq5id9KyiFjJQJ5BSnncAEOSoVOluLiLaKvcLqhdRZntDMhYXgudFMmiRDoxPl4DMmrZeUdEg1tZsCzmPRZaCIVO9fqL7bcWvKPuXh0NT+VZnxGjZwUUtl+XHMFumJNc4ueY6b06bD0PhoVpAX8L9AvRmb58wwyIsjCqyQ5fBkaLZhlMv8vEJM5wXK+xonVuXc6SkuxeSrS5GlqzmcPZt4aLBM3v544FLR5DrqwIv+GmbEjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtmN7w/w2jcIwNEOJxiBZL3Yl5qEkpsh8g8D36vGDxE=;
 b=PMs9AXS4FDgW9dqkTAQw9LQEzU37YmUwxZJBEOs+blUET+CO4gDqdPTJLuzRDCU98Fe91qEE9bbysxdF94UDl3lbPqzeQuBS1rLJ1kwZAFccW2koBKvRIaIap2oxJiNWiz7kQqXLyw4ATci1kjXVwcs4BI3Q+hjTW4GjONlunMRDvXEcB9yX6AqHZlhT17dsIo2LSVH9xkDG3fqBBihcVnPjIBj4/zHwaZNONS+ekZChax/K8++JOdPhEsDp2PTSk0FkFuDR7w2faopuatxpq/HC57j1d6Mv46M7c+NUJGIkpS4ntyDj4q857OY/XfELpE//+o4bz4XZcHCzdMCNwQ==
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com (2603:10a6:102:1c5::10)
 by DB8PR02MB5756.eurprd02.prod.outlook.com (2603:10a6:10:115::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 05:41:24 +0000
Received: from PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46]) by PAXPR02MB7310.eurprd02.prod.outlook.com
 ([fe80::25a4:e5d5:aefc:fe46%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 05:41:24 +0000
From:   "Czerwacki, Eial" <eial.czerwacki@sap.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Arsh, Leonid" <leonid.arsh@sap.com>,
        "Twaig, Oren" <oren.twaig@sap.com>,
        SAP vSMP Linux Maintainer <linux.vsmp@sap.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Eric Biggers <ebiggers@google.com>, Fei Li <fei1.li@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH] drivers/virt/vSMP: new driver
Thread-Topic: [PATCH] drivers/virt/vSMP: new driver
Thread-Index: AQHYt65/iPrYvmlYYEa4JB55YFmqkw==
Date:   Thu, 25 Aug 2022 05:41:24 +0000
Message-ID: <PAXPR02MB731061ECDE7CC340F0C8087081739@PAXPR02MB7310.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fffb7f06-e1d0-4980-43f9-08da865c7286
x-ms-traffictypediagnostic: DB8PR02MB5756:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mx/FS/DC68933SYbCRvZT0727gw1s0QocW27mifGv8N1QBsfm/ud2eaAyrd5cjuJVCgAk0XnBgR/7Xcb0Z8ZDflZk9Ob7kKtNjRS2K8ZNxNwO7QfF2DaMg67WtUe8EE5HWP3+SFrbs5PN2IYmwZ2bXLyAcxEX7vi+/g3LaLDBAjjKAN9RBg72Gd9txZDXv6nYXYsc4VvNpEOgN+zuQ26AIBixrf5TkVthVnfjbOQqofqSc9grs+zcixqI0nLho1vsFK8L2QpDGkpYvP7kTHf8FTEIs7XxKFKcbbntS07TuJNZTMis19LW+PSJqD+fxm/M+79SNdii725EBZOhNFxe2z729CtUepIeqsK1h5WT8662Jzy+J4ftsfZdUUgGrUvDVwvA0y9FqdxIMssIP2CQHQkLyPcxjiwP+GcZYvhPJwbFYnZLD+ZPdmVdRz78BIO5TinwuKRVuKw8NjBJqqUBh2B81MpIpG52j4YlI0dMzol2WFv+JZAyYxz12UINo9WCLK8nPRrafg3H9wAX3hXX7rdbTyMlAbIZrRUmCY8zLVbA6G7VeKod8pjmBixK1hZbxS7BgPoLulWII9f5Vnnx0aWvFLiTXu76qAAIrmOGpdau6y+kj0eE/zXiqb3t+iJvI8DfwtwxD1Ugphg9dlYSLUd2PrgUXslKQqv1ncMmcez5oT18kytHPhlJR2ypoa6V4cxcAM/MpKV8Gz7B8r8IxmGp/CZtM9bevJSm0bWRQLhWrm2QJeYDXBKNdh44swMtjLO/2eN16CLbMXSjVBC/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR02MB7310.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(38100700002)(6506007)(55016003)(316002)(54906003)(71200400001)(2906002)(26005)(122000001)(6916009)(7696005)(82960400001)(9686003)(66946007)(66446008)(76116006)(66476007)(4326008)(8676002)(91956017)(8936002)(66556008)(64756008)(86362001)(38070700005)(83380400001)(478600001)(33656002)(186003)(52536014)(41300700001)(30864003)(5660300002)(7416002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?p9EQ4PTXSBgjWpIEmZt7nJLXAYwkTTgTpnBmcPF1JCzKYCGof22PzUJmKi?=
 =?iso-8859-1?Q?n1yxNIdupt5W1H7p0Z0QCcTsxiRtMQ5nZT0uUlBIwpZOcoH/E+7ac2nY3D?=
 =?iso-8859-1?Q?ThNeClQNHoxuklhCxExrj0QI2eNhJwVj4z6NVMYcODEcgCC4C0EW226+je?=
 =?iso-8859-1?Q?Mf6EhZVwK0jHuJDM5m5qwI2omZH0hKP1h8+Nfz/D64lCRKHLmFZYjXDy1/?=
 =?iso-8859-1?Q?IfrjTnM38EV6QISfoKQPkDmHj3OyaX/niXDGsKYtTMwTxWNvfPlgtsBW5h?=
 =?iso-8859-1?Q?fPs0S+PjE+HRmubfV7BNrDjh3MSl/4dVaCeVV3A2le7nLSKMJGeXeWPC8E?=
 =?iso-8859-1?Q?JB+Oh3EgSy4q3HhlCFS2HTReXpdWFyKz7S2W9HDV9pdTVWPTlRpfCPC7Pg?=
 =?iso-8859-1?Q?zTjG+0L7wm7WU1ohrZ/NdrlyJ1SxC63p1QEf6E5IFlP+NHaEI9ZTBNzaR5?=
 =?iso-8859-1?Q?QV53Kpr9nJkMmf6sfkmZvowme5Apm+Yicd0x9i9V8DltEu01jng+vUHrFw?=
 =?iso-8859-1?Q?vFBL1e7QQVJtshNUrzfpXJ1GJiM5J6eQ08lG8jYlEEovQbUlOzK1nmIGKJ?=
 =?iso-8859-1?Q?li6UqnwdG3Q4ZswGjW2OwvsDvn9Gae4o7iqsHURNY0xG2wxQV703jgIe6r?=
 =?iso-8859-1?Q?YuVpCs00y5pAPHsAKOs0e9GXeEfdmM94+FX+IYiqL93F7xD8u0qzHegcKo?=
 =?iso-8859-1?Q?cCQ5jFyH1UKPIvBQvEXZ2GGw3+yLCiV/hYM1l1lBF6K6WCeBtEzsEDItat?=
 =?iso-8859-1?Q?ucTZtCtAQ+WPvYGJ+KMtxZlR7nbYaPa5JYA1UvaKuzqUqUlLWFyW9OUZnm?=
 =?iso-8859-1?Q?cXQPIAoZVNtBltG6ynfumKjrI2ndiBuAgSu0tmvu94rV9MEAE1yceYSVX4?=
 =?iso-8859-1?Q?PfdWNXh9X79UtnJDmRpMoYIGQqyizBmFJ5ni+0bEQHn65M6ajjA9Lp4lYU?=
 =?iso-8859-1?Q?a7J09KjSzjZRLkmy7vn8Ffn8YyA8w3I8MdZVbxj2MZy2gtsa05AIsvuKLj?=
 =?iso-8859-1?Q?SRpwRKE2h6bUrlhQ6aO8F7BJQUaRpCHCSbMZlMtSIIvQgZX2WDC004zwGc?=
 =?iso-8859-1?Q?WesY94p0DBqu4AB+r0725NY0iTwNH5Yt3cbpiGshOEXpfptzMSFUhjD6yO?=
 =?iso-8859-1?Q?0qcz2VcrkBZzPK+y+e5ZYhxfIHXEAk6x215WISBXa4V8wU/BdvSeTQNNvC?=
 =?iso-8859-1?Q?zd8wgp4/wVEW6EAh1yQcEOUgEfN32+C5Ox1jDq6V0vx/mhnOlgHkCafDkO?=
 =?iso-8859-1?Q?JexG1eA7/XUtPriOHhcQHC2x+wOzN/Ofb7ICACoFqc035m1afO4d/kCMKr?=
 =?iso-8859-1?Q?g+KCZktt06vQj0ug0vamK65YqMDZJAiNcMQAr2cobn/LLG5VklAPWlPnIH?=
 =?iso-8859-1?Q?wgGuX2xAJrQi7+/A/1Am9mfDHDWyATebYjlbwFU07McHkFlJGdlaaaNbKm?=
 =?iso-8859-1?Q?tdyVSsWq4ixvud+vH6zmT8F25R6RLv/dLPbySWpgUiHcsWswCRwYKY4mcV?=
 =?iso-8859-1?Q?b4EjjYGU60zcNwrFidK+6R1AwqA+cknrOpmzJtGM8nklLdlVZ6aEENHWGe?=
 =?iso-8859-1?Q?hvbfhd+MMVHoqHD2nvQXBs0diMG7VccbBFHPwz3AtzTLOXrjPqKWedzicg?=
 =?iso-8859-1?Q?JbqdwkLTW1LNYAXA59kmiapUF8MAuZSb0x?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7310.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffb7f06-e1d0-4980-43f9-08da865c7286
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 05:41:24.2236
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tSu1xmmj8cu+6jD0BBqMACzgJv1NyMo67C5bxD3kpSQMfVtBynzD/A5TlSIkiGI47+7ueoVR0J9TihqGMcV6bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5756
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing the vSMP guest driver which allows interaction with the=0A=
vSMP control device when running a Linux OS atop of the vSMP hypervisor.=0A=
vSMP is a resource aggregation hypervisor from SAP.=0A=
=0A=
The driver comprises of api part which facilitates communication with=0A=
the hypervisor and version which displays the hypervisor's version.=0A=
=0A=
This patch s based on previous patches sent to the staging tree mailing=0A=
lists=0A=
=0A=
Signed-off-by: Eial Czerwacki <eial.czerwacki@sap.com>=0A=
Acked-by: Leonid Arsh <leonid.arsh@sap.com>=0A=
Acked-by: Oren Twaig <oren.twaig@sap.com>=0A=
CC: SAP vSMP Linux Maintainer <linux.vsmp@sap.com>=0A=
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org> =0A=
CC: Arnd Bergmann <arnd@arndb.de>=0A=
CC: Dan Carpenter <dan.carpenter@oracle.com>=0A=
CC: Andra Paraschiv <andraprs@amazon.com> =0A=
CC: Borislav Petkov <bp@suse.de> =0A=
CC: Brijesh Singh <brijesh.singh@amd.com> =0A=
CC: Eric Biggers <ebiggers@google.com> =0A=
CC: Fei Li <fei1.li@intel.com> =0A=
CC: Hans de Goede <hdegoede@redhat.com> =0A=
CC: Jens Axboe <axboe@kernel.dk> =0A=
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =0A=
---=0A=
 Documentation/ABI/stable/sysfs-driver-vsmp |   5 +=0A=
 MAINTAINERS                                |   6 +=0A=
 drivers/virt/Kconfig                       |   2 +=0A=
 drivers/virt/Makefile                      |   2 +=0A=
 drivers/virt/vsmp/Kconfig                  |  11 +=0A=
 drivers/virt/vsmp/Makefile                 |   7 +=0A=
 drivers/virt/vsmp/api/api.c                | 249 +++++++++++++++++++++=0A=
 drivers/virt/vsmp/api/api.h                |  69 ++++++=0A=
 drivers/virt/vsmp/include/registers.h      |  12 +=0A=
 drivers/virt/vsmp/version/version.c        | 118 ++++++++++=0A=
 drivers/virt/vsmp/version/version.h        |  14 ++=0A=
 drivers/virt/vsmp/vsmp_main.c              | 110 +++++++++=0A=
 12 files changed, 605 insertions(+)=0A=
 create mode 100644 Documentation/ABI/stable/sysfs-driver-vsmp=0A=
 create mode 100644 drivers/virt/vsmp/Kconfig=0A=
 create mode 100644 drivers/virt/vsmp/Makefile=0A=
 create mode 100644 drivers/virt/vsmp/api/api.c=0A=
 create mode 100644 drivers/virt/vsmp/api/api.h=0A=
 create mode 100644 drivers/virt/vsmp/include/registers.h=0A=
 create mode 100644 drivers/virt/vsmp/version/version.c=0A=
 create mode 100644 drivers/virt/vsmp/version/version.h=0A=
 create mode 100644 drivers/virt/vsmp/vsmp_main.c=0A=
=0A=
diff --git a/Documentation/ABI/stable/sysfs-driver-vsmp b/Documentation/ABI=
/stable/sysfs-driver-vsmp=0A=
new file mode 100644=0A=
index 000000000000..18a0a62f40ed=0A=
--- /dev/null=0A=
+++ b/Documentation/ABI/stable/sysfs-driver-vsmp=0A=
@@ -0,0 +1,5 @@=0A=
+What:           /sys/hypervisor/vsmp/version=0A=
+Date:           Aug 2022=0A=
+Contact:        Eial Czerwacki <eial.czerwacki@sap.com>=0A=
+		linux-vsmp@sap.com=0A=
+Description:    Shows the full version of the vSMP hypervisor=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index f512b430c7cb..cf74089c4d19 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -21783,6 +21783,12 @@ F:	lib/test_printf.c=0A=
 F:	lib/test_scanf.c=0A=
 F:	lib/vsprintf.c=0A=
 =0A=
+VSMP GUEST DRIVER=0A=
+M:	Eial Czerwacki <eial.czerwacki@sap.com>=0A=
+M:	linux-vsmp@sap.com=0A=
+S:	Maintained=0A=
+F:	drivers/virt/vsmp=0A=
+=0A=
 VT1211 HARDWARE MONITOR DRIVER=0A=
 M:	Juerg Haefliger <juergh@gmail.com>=0A=
 L:	linux-hwmon@vger.kernel.org=0A=
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig=0A=
index 87ef258cec64..9f283f476674 100644=0A=
--- a/drivers/virt/Kconfig=0A=
+++ b/drivers/virt/Kconfig=0A=
@@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"=0A=
 =0A=
 source "drivers/virt/coco/sev-guest/Kconfig"=0A=
 =0A=
+source "drivers/virt/vsmp/Kconfig"=0A=
+=0A=
 endif=0A=
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile=0A=
index 093674e05c40..159ba37cb471 100644=0A=
--- a/drivers/virt/Makefile=0A=
+++ b/drivers/virt/Makefile=0A=
@@ -11,3 +11,5 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+=3D nitro_enclaves/=0A=
 obj-$(CONFIG_ACRN_HSM)		+=3D acrn/=0A=
 obj-$(CONFIG_EFI_SECRET)	+=3D coco/efi_secret/=0A=
 obj-$(CONFIG_SEV_GUEST)		+=3D coco/sev-guest/=0A=
+=0A=
+obj-$(CONFIG_VSMP)             +=3D vsmp/=0A=
diff --git a/drivers/virt/vsmp/Kconfig b/drivers/virt/vsmp/Kconfig=0A=
new file mode 100644=0A=
index 000000000000..4e1d7e0dc746=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/Kconfig=0A=
@@ -0,0 +1,11 @@=0A=
+# SPDX-License-Identifier: GPL-2.0-only=0A=
+config VSMP=0A=
+	tristate "vSMP Guest Support"=0A=
+	depends on SYS_HYPERVISOR && X86_64 && PCI=0A=
+	help=0A=
+	  Support for vSMP Guest Driver.=0A=
+=0A=
+	  This driver allows information gathering of data from the vSMP hypervis=
or when=0A=
+	  running on top of a vSMP-based hypervisor.=0A=
+=0A=
+	  If unsure, say no.=0A=
diff --git a/drivers/virt/vsmp/Makefile b/drivers/virt/vsmp/Makefile=0A=
new file mode 100644=0A=
index 000000000000..f637097e19f2=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/Makefile=0A=
@@ -0,0 +1,7 @@=0A=
+# SPDX-License-Identifier: GPL-2.0=0A=
+#=0A=
+# Makefile for vSMP Guest drivers=0A=
+#=0A=
+=0A=
+obj-$(CONFIG_VSMP) =3D vsmp.o=0A=
+vsmp-y :=3D vsmp_main.o api/api.o version/version.o=0A=
diff --git a/drivers/virt/vsmp/api/api.c b/drivers/virt/vsmp/api/api.c=0A=
new file mode 100644=0A=
index 000000000000..6e40935907bc=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/api/api.c=0A=
@@ -0,0 +1,249 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+=0A=
+/*=0A=
+ * vSMP driver api=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#include "api.h"=0A=
+=0A=
+static void __iomem *cfg_addr;=0A=
+static struct kobject *vsmp_sysfs_kobj;=0A=
+static struct pci_dev *vsmp_dev_obj;=0A=
+=0A=
+/* R/W ops handlers */=0A=
+=0A=
+/*=0A=
+ * Init a vsmp firmware operation object=0A=
+ */=0A=
+int vsmp_init_op(struct fw_ops *op, ssize_t max_size,=0A=
+		 enum vsmp_fw_action action)=0A=
+{=0A=
+	op->hwi_block_size =3D max_size;=0A=
+	op->action =3D action;=0A=
+	op->buff_offset =3D op->hwi_block_size;=0A=
+=0A=
+	op->buff =3D kzalloc(op->hwi_block_size, GFP_KERNEL);=0A=
+	if (!op->buff)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	vsmp_reset_op(op);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Release an vsmp firmware operation object=0A=
+ */=0A=
+void vsmp_release_op(struct fw_ops *op)=0A=
+{=0A=
+	if (!op) {=0A=
+		WARN_ON(!op);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	if (!op->buff) {=0A=
+		WARN_ON(!op->buff);=0A=
+		return;=0A=
+	}=0A=
+=0A=
+	kfree(op->buff);=0A=
+	memset(op, 0, sizeof(*op));=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Reset a vsmp firmware operation object=0A=
+ */=0A=
+void vsmp_reset_op(struct fw_ops *op)=0A=
+{=0A=
+	memset(op->buff, 0, op->hwi_block_size);=0A=
+	op->buff_offset =3D op->hwi_block_size;=0A=
+}=0A=
+=0A=
+/* Regs/Buffs R/W handlers */=0A=
+=0A=
+/*=0A=
+ * Read a value from a specific register in the vSMP's device config space=
=0A=
+ */=0A=
+u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type)=0A=
+{=0A=
+	u64 ret_val;=0A=
+=0A=
+	switch (type) {=0A=
+	case VSMP_CTL_REG_SIZE_8BIT:=0A=
+		ret_val =3D readb(cfg_addr + reg);=0A=
+		break;=0A=
+=0A=
+	case VSMP_CTL_REG_SIZE_16BIT:=0A=
+		ret_val =3D readw(cfg_addr + reg);=0A=
+		break;=0A=
+=0A=
+	case VSMP_CTL_REG_SIZE_32BIT:=0A=
+		ret_val =3D readl(cfg_addr + reg);=0A=
+		break;=0A=
+=0A=
+	case VSMP_CTL_REG_SIZE_64BIT:=0A=
+		ret_val =3D readq(cfg_addr + reg);=0A=
+		break;=0A=
+=0A=
+	default:=0A=
+		dev_err(get_dev(), "Unsupported reg size type %d.\n", type);=0A=
+		ret_val =3D (u64) -EINVAL;=0A=
+	}=0A=
+=0A=
+	dev_dbg(get_dev(), "%s: read 0x%llx from reg 0x%llx of %d bits\n",=0A=
+		__func__, ret_val, reg, (type + 1) * 8);=0A=
+	return ret_val;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read a buffer from the bar byte by byte for halt on=0A=
+ * null termination.=0A=
+ * Expected buffs are strings.=0A=
+ */=0A=
+static ssize_t read_buff_from_bar_in_bytes(char *out, u8 __iomem *buff, ss=
ize_t len)=0A=
+{=0A=
+	u32 i;=0A=
+=0A=
+	for (i =3D 0; i < len; i++) {=0A=
+		out[i] =3D ioread8(&buff[i]);=0A=
+		if (!out[i])=0A=
+			break;=0A=
+	}=0A=
+=0A=
+	return i;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Read a buffer from a specific offset in a specific bar,=0A=
+ * maxed to a predefined len size-wise from the vSMP device=0A=
+ */=0A=
+int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,=0A=
+			    bool halt_on_null)=0A=
+{=0A=
+	u8 __iomem *buff;=0A=
+	u64 bar_start =3D pci_resource_start(vsmp_dev_obj, bar);=0A=
+	u32 bar_len =3D pci_resource_len(vsmp_dev_obj, bar);=0A=
+	ssize_t actual_len =3D len;=0A=
+=0A=
+	/* incase of overflow, warn and use max len possible */=0A=
+	if ((offset + len) > bar_len) {=0A=
+		WARN_ON((offset + len) > actual_len);=0A=
+		actual_len =3D bar_len - offset;=0A=
+		dev_dbg(get_dev(), "%lu overflows bar len, using %ld len instead\n",=0A=
+			len, actual_len);=0A=
+	}=0A=
+=0A=
+	buff =3D ioremap(bar_start + offset, actual_len);=0A=
+	if (!buff)=0A=
+		return -ENOMEM;=0A=
+=0A=
+	if (halt_on_null)=0A=
+		read_buff_from_bar_in_bytes(out, buff, len);=0A=
+	else=0A=
+		memcpy_fromio(out, buff, len);=0A=
+=0A=
+	iounmap(buff);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Generic function to read from the bar=0A=
+ */=0A=
+ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,=0A=
+			       char *buf, loff_t off, ssize_t count)=0A=
+{=0A=
+	ssize_t ret_val =3D 0;=0A=
+=0A=
+	if (op->buff_offset >=3D op->hwi_block_size) {	/* perform H/W op */=0A=
+		vsmp_reset_op(op);=0A=
+=0A=
+		ret_val =3D vsmp_read_buff_from_bar(bar, reg, op->buff, op->hwi_block_si=
ze, false);=0A=
+		if (ret_val) {=0A=
+			dev_err(get_dev(), "%s operation failed\n",=0A=
+				(op->action =3D=3D FW_READ) ? "read" : "write");=0A=
+		}=0A=
+		op->buff_offset =3D 0;=0A=
+	}=0A=
+=0A=
+	if (ret_val)=0A=
+		return ret_val;=0A=
+=0A=
+	return memory_read_from_buffer(buf, count, &op->buff_offset, op->buff, op=
->hwi_block_size);=0A=
+}=0A=
+=0A=
+/* sysfs handlers */=0A=
+=0A=
+/*=0A=
+ * Register the vSMP sysfs object for user space interaction=0A=
+ */=0A=
+int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr)=0A=
+{=0A=
+	int error =3D -EINVAL;=0A=
+=0A=
+	if (vsmp_sysfs_kobj && bin_attr) {=0A=
+		error =3D sysfs_create_bin_file(vsmp_sysfs_kobj, bin_attr);=0A=
+		if (error)=0A=
+			dev_err(get_dev(), "Failed to register sysfs entry (%d)\n", error);=0A=
+	}=0A=
+=0A=
+	return error;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Deregister the vSMP sysfs object for user space interaction=0A=
+ */=0A=
+void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr)=0A=
+{=0A=
+	if (vsmp_sysfs_kobj && bin_attr)=0A=
+		sysfs_remove_bin_file(vsmp_sysfs_kobj, bin_attr);=0A=
+}=0A=
+=0A=
+/* Generic functions */=0A=
+=0A=
+/*=0A=
+ * Open the cfg address space of the vSDP device=0A=
+ */=0A=
+int open_cfg_addr(struct pci_dev *pdev)=0A=
+{=0A=
+	u64 cfg_start;=0A=
+	u32 cfg_len;=0A=
+=0A=
+	vsmp_dev_obj =3D pdev;=0A=
+	cfg_start =3D pci_resource_start(vsmp_dev_obj, 0);=0A=
+	cfg_len =3D pci_resource_len(vsmp_dev_obj, 0);=0A=
+=0A=
+	dev_dbg(get_dev(), "Mapping bar 0: [0x%llx,0x%llx]\n",=0A=
+		cfg_start, cfg_start + cfg_len);=0A=
+=0A=
+	cfg_addr =3D ioremap(cfg_start, cfg_len);=0A=
+	if (!cfg_addr) {=0A=
+		dev_err(get_dev(), "Failed to map vSMP pci controller, exiting.\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+int init_sysfs(void)=0A=
+{=0A=
+	vsmp_sysfs_kobj =3D kobject_create_and_add("vsmp", hypervisor_kobj);=0A=
+	if (!vsmp_sysfs_kobj) {=0A=
+		dev_err(get_dev(), "Failed to create vSMP sysfs entry, exiting.\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+void cleanup(void)=0A=
+{=0A=
+	iounmap(cfg_addr);=0A=
+	kobject_put(vsmp_sysfs_kobj);=0A=
+}=0A=
+=0A=
+const struct device *get_dev(void)=0A=
+{=0A=
+	return &vsmp_dev_obj->dev;=0A=
+}=0A=
diff --git a/drivers/virt/vsmp/api/api.h b/drivers/virt/vsmp/api/api.h=0A=
new file mode 100644=0A=
index 000000000000..6142e947979f=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/api/api.h=0A=
@@ -0,0 +1,69 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+=0A=
+/*=0A=
+ * vSMP driver api header=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#ifndef VSMP_API_H=0A=
+#define VSMP_API_H=0A=
+=0A=
+#include <linux/pci.h>=0A=
+=0A=
+// R/W ops handlers=0A=
+#define vsmp_read_reg32_from_cfg(_reg_) \=0A=
+	((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_32BIT))=0A=
+=0A=
+enum reg_size_type {=0A=
+	VSMP_CTL_REG_SIZE_8BIT =3D 0,=0A=
+	VSMP_CTL_REG_SIZE_16BIT,=0A=
+	VSMP_CTL_REG_SIZE_32BIT,=0A=
+	VSMP_CTL_REG_SIZE_64BIT=0A=
+};=0A=
+=0A=
+enum vsmp_fw_action {=0A=
+	FW_READ =3D 0,=0A=
+	FW_WRITE =3D 1=0A=
+};=0A=
+=0A=
+struct fw_ops {=0A=
+	enum vsmp_fw_action action;=0A=
+	ssize_t hwi_block_size;=0A=
+	unsigned char *buff;=0A=
+	loff_t buff_offset;=0A=
+	bool in_progress;=0A=
+};=0A=
+=0A=
+int vsmp_init_op(struct fw_ops *op, ssize_t max_size,=0A=
+		 enum vsmp_fw_action action);=0A=
+void vsmp_release_op(struct fw_ops *op);=0A=
+void vsmp_reset_op(struct fw_ops *op);=0A=
+=0A=
+#define FILE_PREM 0444=0A=
+=0A=
+/* Regs/Buffs R/W handlers */=0A=
+#define vsmp_read_reg32_from_cfg(_reg_) \=0A=
+	((u32) vsmp_read_reg_from_cfg((_reg_), VSMP_CTL_REG_SIZE_32BIT))=0A=
+=0A=
+u64 vsmp_read_reg_from_cfg(u64 reg, enum reg_size_type type);=0A=
+ssize_t vsmp_generic_buff_read(struct fw_ops *op, u8 bar, u64 reg,=0A=
+			       char *buf, loff_t off, ssize_t count);=0A=
+int vsmp_read_buff_from_bar(u8 bar, u32 offset, char *out, ssize_t len,=0A=
+			    bool halt_on_null);=0A=
+=0A=
+typedef int (*sysfs_register_cb)(void);=0A=
+typedef void (*sysfs_deregister_cb)(void);=0A=
+=0A=
+struct sysfs_entry_cbs {=0A=
+	sysfs_register_cb reg_cb;=0A=
+	sysfs_deregister_cb dereg_cb;=0A=
+};=0A=
+=0A=
+int vsmp_register_sysfs_group(const struct bin_attribute *bin_attr);=0A=
+void vsmp_deregister_sysfs_group(const struct bin_attribute *bin_attr);=0A=
+=0A=
+int open_cfg_addr(struct pci_dev *pdev);=0A=
+int init_sysfs(void);=0A=
+void cleanup(void);=0A=
+const struct device *get_dev(void);=0A=
+#endif /* VSMP_API_H */=0A=
diff --git a/drivers/virt/vsmp/include/registers.h b/drivers/virt/vsmp/incl=
ude/registers.h=0A=
new file mode 100644=0A=
index 000000000000..b6458d25e3b7=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/include/registers.h=0A=
@@ -0,0 +1,12 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+/*=0A=
+ * vSMP driver registers=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#ifndef VSMP_REGSITERS_H=0A=
+#define VSMP_REGSITERS_H=0A=
+=0A=
+#define VSMP_VERSION_REG 0x0c=0A=
+=0A=
+#endif /* VSMP_REGSITERS_H */=0A=
diff --git a/drivers/virt/vsmp/version/version.c b/drivers/virt/vsmp/versio=
n/version.c=0A=
new file mode 100644=0A=
index 000000000000..d8ad771daf28=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/version/version.c=0A=
@@ -0,0 +1,118 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+=0A=
+/*=0A=
+ * vSMP driver version module=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#include <linux/slab.h>=0A=
+#include <linux/kobject.h>=0A=
+=0A=
+#include "../api/api.h"=0A=
+#include "../include/registers.h"=0A=
+=0A=
+/*=0A=
+ * This is the maximal possible length of the version which is a text stri=
ng=0A=
+ * the real len is usually much smaller, thus the driver uses this once to=
 read=0A=
+ * the version string and record it's actual len.=0A=
+ * From that point and on, the actual len will be used in each call.=0A=
+ */=0A=
+#define VERSION_MAX_LEN (1 << 19)=0A=
+=0A=
+static struct fw_ops op;=0A=
+=0A=
+static ssize_t version_read(struct file *filp, struct kobject *kobj,=0A=
+			    struct bin_attribute *bin_attr,=0A=
+			    char *buf, loff_t off, size_t count)=0A=
+{=0A=
+	u64 reg_val =3D vsmp_read_reg32_from_cfg(VSMP_VERSION_REG);=0A=
+	ssize_t ret_val;=0A=
+=0A=
+	if (reg_val < 0) {=0A=
+		dev_err(get_dev(), "Failed to value of reg 0x%x\n", VSMP_VERSION_REG);=
=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	ret_val =3D vsmp_generic_buff_read(&op, 0, reg_val, buf, off, count);=0A=
+	if (ret_val < 0) {=0A=
+		dev_err(get_dev(), "Failed to read version (%ld)\n", ret_val);=0A=
+		return 0;=0A=
+	}=0A=
+=0A=
+	buf[ret_val++] =3D '\n';=0A=
+=0A=
+	return ret_val;=0A=
+}=0A=
+=0A=
+struct bin_attribute version_raw_attr =3D __BIN_ATTR(version, FILE_PREM,=
=0A=
+						   version_read, NULL, VERSION_MAX_LEN);=0A=
+=0A=
+/*=0A=
+ * Retrieve str in order to determine the proper length.=0A=
+ * This is the best way to maintain backwards compatibility with all=0A=
+ * vSMP versions.=0A=
+ */=0A=
+static ssize_t get_version_len(void)=0A=
+{=0A=
+	ssize_t len =3D 0;=0A=
+	u64 reg_val =3D vsmp_read_reg32_from_cfg(VSMP_VERSION_REG);=0A=
+	char *version_str =3D kzalloc(VERSION_MAX_LEN, GFP_KERNEL);=0A=
+=0A=
+	if (!version_str)=0A=
+		return len;=0A=
+=0A=
+	if (vsmp_read_reg32_from_cfg(VSMP_VERSION_REG) < 0) {=0A=
+		kfree(version_str);=0A=
+		dev_err(get_dev(), "Failed to read value of reg 0x%x\n", VSMP_VERSION_RE=
G);=0A=
+		return len;=0A=
+	}=0A=
+=0A=
+	memset(version_str, 0, VERSION_MAX_LEN);=0A=
+	if (vsmp_read_buff_from_bar(0, reg_val, version_str, VERSION_MAX_LEN, tru=
e)) {=0A=
+		kfree(version_str);=0A=
+		dev_err(get_dev(), "Failed to read buffer from bar\n");=0A=
+		return len;=0A=
+	}=0A=
+=0A=
+	len =3D strlen(version_str);=0A=
+	kfree(version_str);=0A=
+=0A=
+	return len;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Register the version sysfs entry=0A=
+ */=0A=
+int sysfs_register_version_cb(void)=0A=
+{=0A=
+	ssize_t len =3D get_version_len();=0A=
+	int ret_val;=0A=
+=0A=
+	if (!len) {=0A=
+		dev_err(get_dev(), "Failed to init vSMP version module\n");=0A=
+		return -EINVAL;=0A=
+	}=0A=
+	version_raw_attr.size =3D len;=0A=
+=0A=
+	if (vsmp_init_op(&op, version_raw_attr.size, FW_READ)) {=0A=
+		dev_err(get_dev(), "Failed to init vSMP version op\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	ret_val =3D vsmp_register_sysfs_group(&version_raw_attr);=0A=
+	if (ret_val) {=0A=
+		dev_err(get_dev(), "Failed to init vSMP version support\n");=0A=
+		vsmp_release_op(&op);=0A=
+	}=0A=
+=0A=
+	return ret_val;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Deregister the version sysfs entry=0A=
+ */=0A=
+void sysfs_deregister_version_cb(void)=0A=
+{=0A=
+	vsmp_deregister_sysfs_group(&version_raw_attr);=0A=
+	vsmp_release_op(&op);=0A=
+}=0A=
diff --git a/drivers/virt/vsmp/version/version.h b/drivers/virt/vsmp/versio=
n/version.h=0A=
new file mode 100644=0A=
index 000000000000..c4430b3065e4=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/version/version.h=0A=
@@ -0,0 +1,14 @@=0A=
+/* SPDX-License-Identifier: GPL-2.0 */=0A=
+=0A=
+/*=0A=
+ * vSMP driver version module header=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#ifndef VSMP_VERSION_COMMON_H=0A=
+#define VSMP_VERSION_COMMON_H=0A=
+=0A=
+int sysfs_register_version_cb(void);=0A=
+void sysfs_deregister_version_cb(void);=0A=
+=0A=
+#endif /* VSMP_VERSION_COMMON_H */=0A=
diff --git a/drivers/virt/vsmp/vsmp_main.c b/drivers/virt/vsmp/vsmp_main.c=
=0A=
new file mode 100644=0A=
index 000000000000..95704bc7a32f=0A=
--- /dev/null=0A=
+++ b/drivers/virt/vsmp/vsmp_main.c=0A=
@@ -0,0 +1,110 @@=0A=
+// SPDX-License-Identifier: GPL-2.0=0A=
+=0A=
+/*=0A=
+ * vSMP driver main=0A=
+ * (C) Copyright 2022 SAP SE=0A=
+ */=0A=
+=0A=
+#include <linux/module.h>=0A=
+=0A=
+#include "api/api.h"=0A=
+#include "version/version.h"=0A=
+=0A=
+/* modules info */=0A=
+#define DEVICE_NAME "vSMP"=0A=
+#define DRIVER_LICENSE "GPL v2"=0A=
+#define DRIVER_AUTHOR "Eial Czerwacki <eial.czerwacki@sap.com>"=0A=
+#define DRIVER_DESC "vSMP hypervisor driver"=0A=
+#define DRIVER_VERSION "0.1"=0A=
+=0A=
+#define PCI_DEVICE_ID_SAP_FLX_VSMP_CTL 0x1011=0A=
+=0A=
+MODULE_LICENSE(DRIVER_LICENSE);=0A=
+MODULE_AUTHOR(DRIVER_AUTHOR);=0A=
+MODULE_DESCRIPTION(DRIVER_DESC);=0A=
+MODULE_VERSION(DRIVER_VERSION);=0A=
+=0A=
+/* Sysfs handlers */=0A=
+#define create_entry(_label_) \=0A=
+	{ \=0A=
+		.reg_cb =3D sysfs_register_ ## _label_ ## _cb, \=0A=
+		.dereg_cb =3D sysfs_deregister_ ## _label_ ## _cb, \=0A=
+	}=0A=
+=0A=
+static struct sysfs_entry_cbs cbs_arr[] =3D {=0A=
+	create_entry(version),=0A=
+};=0A=
+=0A=
+static const struct pci_device_id vsmp_pci_table[] =3D {=0A=
+	{ PCI_VDEVICE(SCALEMP, PCI_DEVICE_ID_SAP_FLX_VSMP_CTL), 0, },=0A=
+	{ 0, },			/* terminate list */=0A=
+};=0A=
+=0A=
+/*=0A=
+ * Init all submodules's sysfs entries=0A=
+ */=0A=
+static int add_sysfs_entries(void)=0A=
+{=0A=
+	int ret_val =3D -0, i;=0A=
+=0A=
+	for (i =3D 0; (i < ARRAY_SIZE(cbs_arr) && !ret_val); i++) {=0A=
+		ret_val =3D cbs_arr[i].reg_cb();=0A=
+		if (ret_val) {=0A=
+			dev_err(get_dev(), "Failed to init sysfs entry %d (%d).\n",=0A=
+				i, ret_val);=0A=
+		}=0A=
+	}=0A=
+=0A=
+	return ret_val;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Remove all submodules's sysfs entries=0A=
+ */=0A=
+static void remove_sysfs_entries(void)=0A=
+{=0A=
+	int i;=0A=
+=0A=
+	for (i =3D 0; i < ARRAY_SIZE(cbs_arr); i++)=0A=
+		cbs_arr[i].dereg_cb();=0A=
+}=0A=
+=0A=
+static int vsmp_pci_probe(struct pci_dev *pci, const struct pci_device_id =
*id)=0A=
+{=0A=
+	int ret_val;=0A=
+=0A=
+	ret_val =3D open_cfg_addr(pci);=0A=
+	if (ret_val) {=0A=
+		dev_err(get_dev(), "Failed to open cfg addr\n");=0A=
+		return ret_val;=0A=
+	}=0A=
+=0A=
+	if (init_sysfs()) {=0A=
+		dev_err(get_dev(), "Failed to create sysfs folder\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	if (add_sysfs_entries()) {=0A=
+		dev_err(get_dev(), "Failed to create sysfs entries\n");=0A=
+		return -ENODEV;=0A=
+	}=0A=
+=0A=
+	dev_info(get_dev(), "%s up and running\n", DRIVER_DESC);=0A=
+=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void vsmp_pci_remove(struct pci_dev *pci)=0A=
+{=0A=
+	remove_sysfs_entries();=0A=
+	cleanup();=0A=
+}=0A=
+=0A=
+static struct pci_driver vsmp_pci_driver =3D {=0A=
+	.name		=3D DEVICE_NAME,=0A=
+	.id_table	=3D vsmp_pci_table,=0A=
+	.probe		=3D vsmp_pci_probe,=0A=
+	.remove	=3D vsmp_pci_remove,=0A=
+};=0A=
+=0A=
+module_pci_driver(vsmp_pci_driver);=0A=
-- =0A=
2.25.1=0A=
=0A=
