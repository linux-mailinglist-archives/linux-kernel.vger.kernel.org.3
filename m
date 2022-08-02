Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836C6588341
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 22:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiHBU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 16:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiHBU4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 16:56:38 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7432446;
        Tue,  2 Aug 2022 13:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659473797; x=1691009797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=95g0MF3CZZBGvl8nXmZk401Yx37tSDH4Z/FPUYyHG/c=;
  b=v0r7nz+w0XGJZ+rrd+Qv17XxndsqNaLNhQSC/expg1rf1XDufYdqdrBW
   qHRbuXjUW/zQI08tFPJ3BEaYrcRNYDND8cEadcpbGgfkLFIbG/coCgUBt
   aj8wW9/K1Qgfmht90gjCz8pJQ4gSWrxiEy5/KVFXtGV9IhCMR7v9fZ9XZ
   9RlKnfh2jVfULW72RWGBDngKj4NmpzaQ7lGAOZi+EPS8eAiP7YyP34PfB
   zZyfYy4iMdW3mWR9dHU/RBcqMx9Ql1bNs3/nd/cAb+8amBVyhzv5G3TtJ
   tDjRPDR0pKb/hHtfDfVA1tnZRzHSBi4kSb+sJmal1LruIBsbfEjX5CwVb
   A==;
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="170656554"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 13:56:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 13:56:36 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 2 Aug 2022 13:56:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E37Q92Rk+WWZdPUdinoZJquucCyCSNx1jHaxmMK4CXwcwJYz3xhNaO5WvqiXLOO5/BZGzS7pD2dgfWAHfYsrAB9dNlIBjDu3/TL4oEPvr5flhQw4gfBTTYh5U9WpPvn64kTL6jUJ4MpdIeu3UX8guvn3jm5daT5yEj24dzfnL+B/VqVvGLeNskQKkUM9jyfwyUgXcMBaqHF4k/61JSS5gZsUZjsHdqQD5Rife7THXCISyKoP05l5ujRvZfSAKzZF0Hb1QDu9Z6MNVv5+8OpXRihcPeqN3jku8YgO900fTBprSgN6LldnHiGol5qPvGEDhXJOCFwBokDaieECo+fROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95g0MF3CZZBGvl8nXmZk401Yx37tSDH4Z/FPUYyHG/c=;
 b=UAK4kSXJdACBqDl/S45wpvhWVj3zon5tGWe9x3rMhweRJ0dcWlPdBfrAyKL1OkpwNFcBkwM2C6iGn3RRUDzpKfO1vYuBimUfnv6tFKI/2dQlztX6GDiNgUDdz7H9368amBiKLmalXJe0fQ7smB7I9iJj6lZyk/XmNw+6sVvY/IwdIc+OaRettbI6oE/yS5ScGGfOO0tvtOLELvC4fFU3/Ah8hxm4Z80JGZeqpoB5VU+4zZTHzO89p/inkb3kL5TCxMAam6B9utl3LkpaC4uhDIKli7q5qpqbrAw6dtzDaFpa+hHc7MvDqDs3MRxtoIp/1zpRHmMpiaj4gtApE8jaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95g0MF3CZZBGvl8nXmZk401Yx37tSDH4Z/FPUYyHG/c=;
 b=TXcBznS4lLMgZIuNDl6EsNNyAAEFEDIVLciqY4RGcLMg44Fi+by+5z6itXW8NPWHeIFQLl3BYqraNuCX0y4+eioW7Eghjeflj3xOg2eq+sQS5FLCUuugf1AqxDO1mhD1kZ8JX+WKWwKFDhlcY5EX6Sv1zSBVOg64U/Q1hth7siE=
Received: from CY4PR11MB1238.namprd11.prod.outlook.com (2603:10b6:903:2f::17)
 by BYAPR11MB2725.namprd11.prod.outlook.com (2603:10b6:a02:c5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.15; Tue, 2 Aug
 2022 20:56:24 +0000
Received: from CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5]) by CY4PR11MB1238.namprd11.prod.outlook.com
 ([fe80::a43e:b2e:ecf:bdb5%6]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 20:56:24 +0000
From:   <Don.Brace@microchip.com>
To:     <christophe.jaillet@wanadoo.fr>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        <storagedev@microchip.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2/2] scsi: hpsa: Simplify {clear|set}_bit() parameters
Thread-Topic: [PATCH 2/2] scsi: hpsa: Simplify {clear|set}_bit() parameters
Thread-Index: AQHYnGSF314SK+tIV02FMwALwXwGl62cK6b9
Date:   Tue, 2 Aug 2022 20:56:23 +0000
Message-ID: <CY4PR11MB1238464CF07D61B134703EA7E19D9@CY4PR11MB1238.namprd11.prod.outlook.com>
References: <5f975ef43f8b7306e4ac4e2e8ce4bcd53f6092bb.1658340441.git.christophe.jaillet@wanadoo.fr>
 <c3429a22023f58e5e5cc65d6cd7e83fb2bd9b870.1658340442.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <c3429a22023f58e5e5cc65d6cd7e83fb2bd9b870.1658340442.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b790f3ee-ee02-44ae-ce01-08da74c975d6
x-ms-traffictypediagnostic: BYAPR11MB2725:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tFpT1A6tv88HMCqcd05A6z88d3PiKeOiWx1EElCh+yd1L0XbbhU4nEIRvGWU+fvWI27fSMM07kH1aFJvN8mp0Oihtpyhb4CSWsvKHtVrCx3Fcwxz4TCu+boW+fWe/sXRU14KZrO0mxz/c4J8vgrbNGXvjKx3GfYAYbAJk+BG42O+xABuPOzL31seDXLVFhHYVt/vKvy9O/cCgsB6tM6ga3duGwnmhM34E1Qsk6J+3otgoQeL0dgcjPzywB98qEWM13GD5W7+pY0pyVFiCmgCdTHl6PDAGOJAnwl9tHSNYCJFZLGEQtQII36PvkeltPhd6UJQGsjbz+HrPHjpyafD6GWzD8Y9oLSHGFDR0QdpKSxgB/k9uGs0WA8cpoEoL83/Hdqalu9dKoPI46S9ANSpVb8tBO3HFlltw2GnE/1d6cxzOhTTS9exMci76JFQN9S0Vo1vf5gb2D9YQ0O5xgqhPKkYKIEDqdc3rqnYd0Yialwj5ONcFRqpzCiS9ExRXcs6u3jEOAzodmd5fvApZn7m88gff8MsYTi2SvxsX7UpXCbP9fL5MOJu7NMg3p6LgciLFaBkvkMCAT6p7LOUfdiYYgfffI/O4inW0aAXVlszPPiMoNm2fqZsX65d97Z1ElLAcUoGFqFPtbU9ynbWsEJ7GlqdCKx33Q2mcMqeOanbLQzbrS48yrHyv3DbXbwKU9cPuzutK86c3/N3ieoTVmfGkCBpSbbgS+4eUTSUcNLE+6XLQ9IDE/iCY7Wh7muFvabHZ/xAaUZGG0qCLlQcDJhh5wF0xEX4NpgpUhm27LqG1p3IZO13Gdw1Iip9Pv80R3fK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1238.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(346002)(396003)(39860400002)(7696005)(6506007)(76116006)(26005)(9686003)(5660300002)(38100700002)(122000001)(33656002)(38070700005)(53546011)(316002)(966005)(52536014)(186003)(83380400001)(478600001)(91956017)(66946007)(71200400001)(55016003)(4326008)(8676002)(66556008)(66476007)(66446008)(64756008)(86362001)(41300700001)(110136005)(8936002)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?l6Ez5SrDQ5/hXKJmdS2uU/10Cu0mHj2kGBAup/wd7WgpZ5K4Np46K2CRHa?=
 =?iso-8859-1?Q?k16ACJCdRaNzbn1fNBIQekh18epoORaH8PlLPnsWHTfXKBg1ote5/uM0i0?=
 =?iso-8859-1?Q?ddtKgE9eLIVS1inR6GcjNU6ycUAc+LFVacRXD8riPWPg/I6HUXa54SuEq3?=
 =?iso-8859-1?Q?kOakAeLAfKLkBNOGrReAsPyYHTTKEQSi2/LGtR5WhUD08UwbkXmrxAvy7F?=
 =?iso-8859-1?Q?eEJkCJG4L+Y8+rxKRcmZ4eQaYkfAfZBVaGJahv8YRXVpsD8PYwvoKHNgHd?=
 =?iso-8859-1?Q?OOV5z1ClXc3v2HIkJqRUNxVG2H39lQkGd8yan2SsLF3yLlG122ySjXkFjO?=
 =?iso-8859-1?Q?m3mPD8sZUcQFJ3ODGV36X6zCGneOgN9Hce/LUaJQPcaZDCNqkUSS07ZG8c?=
 =?iso-8859-1?Q?9V+vBCxiHF/bWNO08GarA9eUL1Tbu5vWFjLGvcp7632bSZTyYf5kJ75tFc?=
 =?iso-8859-1?Q?DLfkFizNBrRIJO5nldjbl2g+0lhArdtGkxX1p0lxWSyM/IGKoAO5jVTdKj?=
 =?iso-8859-1?Q?FVA3pC86fuhb1wwX92SF9LeZQyHgn1rQcvEyN09aER0F+ndMFo1hJ2buOs?=
 =?iso-8859-1?Q?CLnLemEoGB+cP+tSaEIUbWD/lRSwv/UBrVdy4O/yzXFZUgIjbRdtK6rcZ4?=
 =?iso-8859-1?Q?rtqHh4XwxseBJzVOFYRSppR1OxlpZ3xuQdrjoA7Nz/zvd1vaXhrWPebJVZ?=
 =?iso-8859-1?Q?Q4p/WcM0s7wfAI+ljVzzhetH2YUGwQYCrRHlPVNkb5nb2a6FvEoaMP4ohO?=
 =?iso-8859-1?Q?ielF+Q9JlX9PiKhvK2oO+vpJDa97ru3yaUj5RQ7WQX6ku/i34xNMcFIsDj?=
 =?iso-8859-1?Q?UaOUMK9BCIVaP4vr/UZ+tM/lQvPZOT0XLDtmptE86XCFl9+ohZZEkYfCN/?=
 =?iso-8859-1?Q?TaS8mUgd2JHnUr6pJ7zjUG1+19zgOLJxrxTdLmrQNrM5o55z4bleCYYj4S?=
 =?iso-8859-1?Q?NWdeGp39UknHiLOswsBDDpAPqNerrM+yQv4G53NatUAK5M/WRL3x/Wc4jv?=
 =?iso-8859-1?Q?adyWnybS9C5IiiEFPWzDXQfI9oaCzU58E++unMKevST4a715n8CZpNbHjp?=
 =?iso-8859-1?Q?Z8KwdoYSW5Y0q/lP1hm/csiZjqeGJ/1LRVR/cmvuvMK02J2k3u9DGjP8ui?=
 =?iso-8859-1?Q?R7vTYo1tv90fw7wIwRry2aPddsCxExibS27xLP4ato9J3sFlEx4VHMRmjM?=
 =?iso-8859-1?Q?9kz7bj9rVy1toGZED10PjJGBmfEuclkd9lodu6LGmzGScClJgAo7c+gUcx?=
 =?iso-8859-1?Q?3y8YaNYuiNn6opaA18+5XvRpIvH8tso4LjvV/bu/ECIfuSut1qgVueWkHm?=
 =?iso-8859-1?Q?W9qaXbuzzR8B1ZJGlcxMXfr/aIElRX5xpnDc6/RAyUaiQUzQb+IWmXQ+F2?=
 =?iso-8859-1?Q?kHSSSkyctWaycWjeeOD/V4TnX0IoLR7ObxOp8wunlqEAn2/rCGnRZsNnkS?=
 =?iso-8859-1?Q?wEGwKO0L/qyswqxoJOafApZfWX3rx2e9bVQAd+wusGnJnIyJVQePOPlExm?=
 =?iso-8859-1?Q?Jmwq+e+o7nw+IMg6XEQsoDBKMRSOC3134ibXJsp9d6KzI1QiA///NWxAOZ?=
 =?iso-8859-1?Q?E4eSImN3KrRM6yx+L+HUGSuYtz6ZhiiLeEE6p0i2oOMCH4LksdAWTk+ObI?=
 =?iso-8859-1?Q?+UY6DCKBG7+JMj1KbFcA5/Wdxa7xCjB9MC?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1238.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b790f3ee-ee02-44ae-ce01-08da74c975d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 20:56:23.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ibErPYHF3aLz7mZUXXHCSWeXxFnlh+6WTfP4Lj9ynCgu4Nn/+rS7bpGZxN9HKIzH8967IyBDhiHB5h/1+tLo5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2725
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
Sent: Wednesday, July 20, 2022 1:14 PM=0A=
To: Don Brace - C33706 <Don.Brace@microchip.com>; James E.J. Bottomley <jej=
b@linux.ibm.com>; Martin K. Petersen <martin.petersen@oracle.com>=0A=
Cc: linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; kernel-jan=
itors@vger.kernel.org <kernel-janitors@vger.kernel.org>; Christophe JAILLET=
 <christophe.jaillet@wanadoo.fr>; storagedev <storagedev@microchip.com>; li=
nux-scsi@vger.kernel.org <linux-scsi@vger.kernel.org>=0A=
Subject: [PATCH 2/2] scsi: hpsa: Simplify {clear|set}_bit() parameters =0A=
=A0=0A=
[Some people who received this message don't often get email from christoph=
e.jaillet@wanadoo.fr. Learn why this is important at https://aka.ms/LearnAb=
outSenderIdentification ]=0A=
=0A=
{clear|set}_bit() can take an almost arbitrarily large bit number, so there=
=0A=
is no need to manually compute addresses. This is just redundant.=0A=
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
index 0612ca681200..f8e832b1bc46 100644=0A=
--- a/drivers/scsi/hpsa.c=0A=
+++ b/drivers/scsi/hpsa.c=0A=
@@ -6233,8 +6233,7 @@ static struct CommandList *cmd_alloc(struct ctlr_info=
 *h)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offse=
t =3D (i + 1) % HPSA_NRESERVED_CMDS;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 conti=
nue;=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(i & (BITS_PER_LONG - 1)=
,=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 h->cmd_=
pool_bits + (i / BITS_PER_LONG));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 set_bit(i, h->cmd_pool_bits);=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break; /* it's ours now. */=
=0A=
=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0=A0=A0=A0=A0=A0=A0 hpsa_cmd_partial_init(h, i, c);=0A=
@@ -6261,8 +6260,7 @@ static void cmd_free(struct ctlr_info *h, struct Comm=
andList *c)=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int i;=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i =3D c - h->cmd_pool;=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_bit(i & (BITS_PER_LONG - =
1),=0A=
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 h=
->cmd_pool_bits + (i / BITS_PER_LONG));=0A=
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 clear_bit(i, h->cmd_pool_bits);=
=0A=
=A0=A0=A0=A0=A0=A0=A0 }=0A=
=A0}=0A=
=0A=
--=0A=
2.34.1=0A=
