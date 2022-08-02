Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CDB58833E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiHBUzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHBUzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:55:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3589A12AF7;
        Tue,  2 Aug 2022 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659473742; x=1691009742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N29EL0aJm7BmCLVmypcmwiI3j2MYKq37e3vSxTf177I=;
  b=Ndi0J6dhWBsa8cd9jzjPdRdQ+wFcgljALKIHGxwQOGr1yU5HAXDy1Fta
   t6rh26S/WNzJO78tC23dcYhN/x1YubDNG4Xnc5mWOe8rSfKR50rgPWSY3
   1rFfaYhYtIM/UqRpRmSsbBVQXP/g9WQBw7E0e+Mo562O7eNuxidLn57Ji
   u4tWkgXvHdmOmyi+Om3mrQ4r3j3MmwHnL8XJLwWAamjbf55IDw9Twj1hu
   HT/sLQ+RSyYz03nAQT54wMkYp5QhNYF9loFzV4doKA+J64iZwBnCLOP2r
   +fymTi5lFgYhWmyqa1kDO/kPoCyKBd49Nogok3Fj4dkAgSIS3tVSpzFIx
   g==;
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="174643883"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 13:55:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 13:55:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 2 Aug 2022 13:55:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnRvDEf4r2P8rqqAE0L0aqcC4PL5s5xSZUqLFgGTOd+miRcLmBfQmCp2eGhmrTr4x/rq6N/7raG0RgMibwicqWN51oSfBqds2aQohD496KedeYS1tfNodv/CzDuFbFz52z3qEaHvXFtVAkR9Py6gIRFe5lpMVZ4o1gZgJrn0CpDyZRvkbyZy08v0rHK+PNSRARUma5a+UdGhnn2+kBqmS994y62394ecTCnwVA9WzlEZ3gBreGqA6OSWtb1YAp/4tiZSkjgN9Y37ApjRp//UR8ve18BQveTsiXLrBcYFEvtyTNx73JMo4xEVUbIxYQAEPw4V5qRAsrE4ASvFRlkjJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N29EL0aJm7BmCLVmypcmwiI3j2MYKq37e3vSxTf177I=;
 b=kjH6kjUjzkEWwrCq2eMGkDB6Cl0C/yUe3XqWaNCoA6aRoVgLQMlye+xwDNWIi6xNkOPXV4d89Phq9kViI1Ya4M++IcGpuWb3wIAdCCEi2g2bsAfZ85yhe9lFfccW3jSof4ECmjrnwRUuSZsCpoywuoDJkkvshnPhndeboqah8MOK9R10yHTCji+BvjvnUdrHxzns+6+iA1WfOlTzX8OR1vrbJFiuUbwsVecoNztxkXfNe2PG9TCpNXep9/KGy8NLLkMnFGlvID/UiVPHQt1Go9CqbjvtPwVrkLOGjc8yup2v35k3HKfispYYO5khLR+zsqut+Cj+zhvCvtyu3b1fgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N29EL0aJm7BmCLVmypcmwiI3j2MYKq37e3vSxTf177I=;
 b=dwhaP1K7m/XYvzeTZJVkHhAaFrtwu3lAzV+f4KRDCjKxTmad7g5vN1y6qgdXx+rgAhW7XKtbexX0YffesAq/4y4eXSTDXn9MI3xPp47OHP40/MhAu9Ec0fZ+gPI0IPshsWkimwV4coYHKV2tNp9SsIqyWkjAAps0d82n9VMXE/g=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by MWHPR1101MB2221.namprd11.prod.outlook.com (2603:10b6:301:53::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 20:55:35 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 20:55:35 +0000
From:   <Don.Brace@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <storagedev@microchip.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 1/2] scsi: hpsa: Use the bitmap API to allocate bitmaps
Thread-Topic: [PATCH 1/2] scsi: hpsa: Use the bitmap API to allocate bitmaps
Thread-Index: AQHYnGSWI/4oyZGy3UetumxUgTYGaq2cKwox
Date:   Tue, 2 Aug 2022 20:55:35 +0000
Message-ID: <CY4PR11MB12386187094F752FAED99DDFE19D9@CY4PR11MB1238.namprd11.prod.outlook.com>
References: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1141bfc-67cd-4436-9896-08da74c958ae
x-ms-traffictypediagnostic: MWHPR1101MB2221:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tG1KvAtH2iSsWaFaJV2UxRpdCq8sOyKpevo9Lv2H8Zl1vbOzqHc+7nBKPzOZ1oVObf9ADyyvTWwA33UWyWzl8pfJbR/V3ycQT8ioRk8Us25KMEzkEVMp4D8pqIotjdbS4wEhZIpyFCUqE1FEHnLF4XyGTDK5GESsLLttRqtSfnqH3NBwt7A1PDtWiaQMgeAXYEVLuWz6i6uD+b0u2a0nWQUIds+T67hk6j6pb9zHBhXh4TLBUzuI2uKHSPfQ/ti4Ka5sPoNSXDQsaXJ4RJu/PTRVsE3xFt76hEsSBKXSo3pKqDBwxXTtnTXLh3cyxPfNHEAWMKlNeU7fViWaD92vwbE94nwv7o7UsbzH5DiOZVNA9OvLHo5lx+cqzmuck9vVBQ2IrEpPnBErcUqL8pyhxCeK+dlJHXEO+6VWi7hBM2a/PEqkJHBmkdvpjtlZ5TX148qozXCMrOMNriyDpyG/tjDbNwkOzMipqH8dVNQIN6eoszzBAT68Dw0Tzh2u/wTa9GeMNC1B5+Vb0Q2yvGxKva+XzO/dhc+wl7ZrNNPDt/T0vh6Nf34HYtTYKv5R/gbSRqbdgWHAZTHAHdE1jlw0GWYasM2hiC+xKEpptNuopxPnnu+HAFs5ffMRatQvifRF+1p36PB9efau2uUGPFWqgc3oDRlMuMIsiNejHksFBt+RqVGb7am+xYfdp6/SQFFOii2f087feZ5Hj3BYHZgwI8OyonbZ0EleD2Xoo0lEyApNudSZEUQPOEjIkv5ZuxFBASWeZiHeK85WpGwmkaQaholHZ77T4frFSfy+ZxEoVI9G1BEcwZeh5BkKAQhE5hZZpkTW41DooftY7x5EiP8rOJ7Knyl85181K1fYWBzfIss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(39860400002)(346002)(71200400001)(66946007)(316002)(38070700005)(91956017)(110136005)(76116006)(5660300002)(478600001)(52536014)(66556008)(8676002)(55016003)(54906003)(4326008)(8936002)(64756008)(66476007)(66446008)(83380400001)(86362001)(33656002)(122000001)(186003)(41300700001)(2906002)(38100700002)(9686003)(26005)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?llgAuxNKppOmh5p2/ApjNXc7whY/8CzzPs5M7WYkuOh1JezaAbsM759e8S?=
 =?iso-8859-1?Q?ZGDf35LF9lrss5NllR9/sC8Fxj/8htRNpFu9VBOn2PY5nUR5rIiZnXruB5?=
 =?iso-8859-1?Q?cIeCsY+AheBl70JzRiHK8+4AMlX1U7Tg8lZkOTtMTL8Qu7Zbj0kumCs0PQ?=
 =?iso-8859-1?Q?bysh3yJgdDHnEBgzxwah8kdRgvmxPfZmxPKz7BRWl0+0MONOx/3Jjqc5Y0?=
 =?iso-8859-1?Q?9CDVKrr7xLPeYY9Pwbw2I9TXn5rQTwPCW5rCyW3zg6DtiPok2MPX8w7dwO?=
 =?iso-8859-1?Q?6J4WNdKkrgvmO46diymsbxdd3rRiYKwmOJrvkLS6e3Lcz8xjQgBpBm1R4e?=
 =?iso-8859-1?Q?qcI9fVj0Tp0DjWoh7JwRucBHXsviydHhFLqudoFpvyKTpwXTm8nhtzVTmH?=
 =?iso-8859-1?Q?UmVLImd/gZSVBantMzjxvPcbkpZkP/guH14V1chByXd2OwyMNiludsQqMY?=
 =?iso-8859-1?Q?aBQR+/Z+YXtqjjMHNUuUMQ4ku8tjqH9s+d3yrde6KuZJolPBhvtIe6dajb?=
 =?iso-8859-1?Q?knS02VQNhosULJVqbxiWDhBPPiGG/lC3lXWUvCXa21DzmAkFnWcvQiPGHO?=
 =?iso-8859-1?Q?EFDOrerSLTmM9xymF1bh1IjBLQiC0T+wMRfP+cDOxYbUFSm8q5SuW4UqsB?=
 =?iso-8859-1?Q?TiWeMnr3zQJzImh1HeAuygzsAYGGSRByINxs6u7jJ5ieNBT4eOz69I4Wjw?=
 =?iso-8859-1?Q?CLzj3P8wfKC7fQT27R0qYjS6MpCZ+phzhKJxdIuStXJpXjXT3iEEKocJKT?=
 =?iso-8859-1?Q?O96npcqlH75q/nWwXWn4KIY1ZXntnh1kAbsQYXFnCkNLeRcGQQcVwlBfaD?=
 =?iso-8859-1?Q?oezkbfeFTVQpLLAEiyaPFcA9fAx9suwvOyLh8OhF4+5cRq7/DScsaXepCk?=
 =?iso-8859-1?Q?suiRlUHYSmmwK9XM0n0u8Lhdi21gxAuPQEBRyZhd97494jbqBNBNJespEI?=
 =?iso-8859-1?Q?OLXk/Wzv1DbxiDl8n/D7/fbhJ6+mXQiag/pR5E95Zum9KbkIlSNRwVUU8s?=
 =?iso-8859-1?Q?Ji1XQo3J9tLzZSZ+3AKw8dDh6PfeuBgmjik4joL1qzQhOGuOko8a+vk7+n?=
 =?iso-8859-1?Q?HV7vmfK13bWGrfo2GIT4ZLDhdix8B7x0eRJHs5PiPnvvLg+oDA6p4r60mY?=
 =?iso-8859-1?Q?MjP+VqGDKkLoS7+FtVtwRwXvnQXw65CLcgMg2Jg5fI8Z7qyKiMAyBFw/GS?=
 =?iso-8859-1?Q?nhg/PRtHyrLfAKsJynhd8ijCOdCbUufdqy/aQtkOFoIFbMI35GUk1dz2OP?=
 =?iso-8859-1?Q?DYZbaPkxjuVt/Rk+7gCtFjaySWZ8/k5BsLLMXl4kkt1reb4j3nFnGO0IpU?=
 =?iso-8859-1?Q?DGkJ8+73hPb3KCmAiSPp8CEeRi01Oy5DRuuShJePaKUuKXFz1Iryf4V6g3?=
 =?iso-8859-1?Q?IsnAUXJ+eBh/YjJIegbTu/svFLrbNlqZyypJutzAU6/BAdn3QXmHMGvWw2?=
 =?iso-8859-1?Q?kXT0JaJvY4jPDVKX456kGv2oqZg4K2ClPKwt9HjcZwMUaOC3n63CUb2m8X?=
 =?iso-8859-1?Q?57Xk3R9RvnVFp6ucWFkneZybje4KXulrWX6hjI+xs42m8tAqz1fOs42oBi?=
 =?iso-8859-1?Q?jswnHYq6++MUFUbVQgjyqWY77jR4nP//OQGDxmXgA1yYaKnu37QjSwy4tV?=
 =?iso-8859-1?Q?0KsqPpqtieW84gu5Z7q+cOjOOD5Pw+VgDi?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1141bfc-67cd-4436-9896-08da74c958ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 20:55:35.0807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +MfChrMAA930rQA/kLDXNZ719Se0WclNOyyY7QZV4mb9CYFr/gRFN95BLrSpX3gSX0gEcifiqJmNJ741EikvVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2221
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>=0A=
Sent: Wednesday, July 20, 2022 1:13 PM=0A=
To: Don Brace - C33706 <Don.Brace@microchip.com>; James E.J. Bottomley <jej=
b@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; kernel-jan=
itors@vger.kernel.org <kernel-janitors@vger.kernel.org>; Christophe JAILLET=
 <christophe.jaillet@wanadoo.fr>; storagedev <storagedev@microchip.com>; li=
nux-scsi@vger.kernel.org <linux-scsi@vger.kernel.org>=0A=
Subject: [PATCH 1/2] scsi: hpsa: Use the bitmap API to allocate bitmaps =0A=
=A0=0A=
=0A=
Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.=0A=
=0A=
It is less verbose and it improves the semantic.=0A=
=0A=
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>=0A=
=0A=
Acked-by: Don Brace <don.brace@microchip.com>=0A=
Tested-by: Don Brace <don.brace@microchip.com>=0A=
=0A=
We normally do not make changes to this driver anymore. But the change look=
s good.=0A=
Thanks for your patch. No cover letter to Ack both at the same time.=0A=
=0A=
Don=0A=
---=0A=
=A0drivers/scsi/hpsa.c | 6 ++----=0A=
=A01 file changed, 2 insertions(+), 4 deletions(-)=0A=
=0A=
diff --git a/drivers/scsi/hpsa.c b/drivers/scsi/hpsa.c=0A=
index a47bcce3c9c7..0612ca681200 100644=0A=
--- a/drivers/scsi/hpsa.c=0A=
+++ b/drivers/scsi/hpsa.c=0A=
@@ -8030,7 +8030,7 @@ static int hpsa_init_reset_devices(struct pci_dev *pd=
ev, u32 board_id)=0A=
=0A=
=A0static void hpsa_free_cmd_pool(struct ctlr_info *h)=0A=
=A0{=0A=
-=A0=A0=A0=A0=A0=A0 kfree(h->cmd_pool_bits);=0A=
+=A0=A0=A0=A0=A0=A0 bitmap_free(h->cmd_pool_bits);=0A=
=A0=A0=A0=A0=A0=A0=A0 h->cmd_pool_bits =3D NULL;=0A=
=A0=A0=A0=A0=A0=A0=A0 if (h->cmd_pool) {=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_free_coherent(&h->pdev->d=
ev,=0A=
@@ -8052,9 +8052,7 @@ static void hpsa_free_cmd_pool(struct ctlr_info *h)=
=0A=
=0A=
=A0static int hpsa_alloc_cmd_pool(struct ctlr_info *h)=0A=
=A0{=0A=
-=A0=A0=A0=A0=A0=A0 h->cmd_pool_bits =3D kcalloc(DIV_ROUND_UP(h->nr_cmds, B=
ITS_PER_LONG),=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 sizeof(unsigned long),=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 GFP_KERNEL);=0A=
+=A0=A0=A0=A0=A0=A0 h->cmd_pool_bits =3D bitmap_zalloc(h->nr_cmds, GFP_KERN=
EL);=0A=
=A0=A0=A0=A0=A0=A0=A0 h->cmd_pool =3D dma_alloc_coherent(&h->pdev->dev,=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 h->nr_cmds * size=
of(*h->cmd_pool),=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &h->cmd_pool_dhan=
dle, GFP_KERNEL);=0A=
--=0A=
2.34.1=0A=
