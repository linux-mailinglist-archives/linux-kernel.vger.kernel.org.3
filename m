Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8917A47478B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhLNQVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:21:54 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.7]:45255 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231253AbhLNQVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:21:50 -0500
Received: from 104.47.17.173_.trendmicro.com (unknown [172.21.201.50])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 7E707100022D0;
        Tue, 14 Dec 2021 16:21:49 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639498909.210000
X-TM-MAIL-UUID: e892e192-4d9d-4ab7-ae0c-fe96158653c4
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.173])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 335CD10000409;
        Tue, 14 Dec 2021 16:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzGrlLcnloOCPmhSfgPQ5+UHILP1e/HMicN0KuxL+yXjVvUOKH99bAvrtU0FCC8qwO7YoqUxjovMVI60p2o2yUQvSeN3BHHUXvC6PyMKsNHlgW8Hv7kdwdBEc/DfGNHU3kT40O7DhNdO/XTUpBYH8zCfoU/SSptLms80Nz9fHfH/i6Rm/aFqc2T/umTcbvwhmPSLc8JkgbW5NtmL7IofdyWSLXxe7zROnJ0oyMhB/cipVipy78TVq6aA8QNttaJsVLXvfUruKfA710xSXFZjUNHnztupetAyJPHkJ5KWbFjuJvalvwI1J19+NrdYLweTc/movEYSa7B26mskODhEZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bD2GL2fEmqHy9IgzI90koFRU2Wv+D4w4XqjRMK49R5w=;
 b=DEY+sV3viyKYkGZKR0zAPN1Yo3zVoINSLOBRjoCTxqA6CGQfKKM5cv6RB25VRBLHkeiWZmko/RH6c2Qf344wK2r/zhPZ/9nySNKtIlKOh2NfrSDwV/oWmJyGVHFDSJUvMAABMh77EvpCxufSVm2XIPbYlv8bE+Rir75iUkk50AJ3k8DTikmqxpnATpyEft+PmtOEr6jwPYDmoArE5TQTywxm2/i5zz2BaVlqypEqwgjumVtI+77DKI+54NDlHKDdPJgRbfbsmq5IHJc5r5UOrT9J/eWSRsWYWSjbnAdVpwPtvRlpv+/vOnNKmpBmWNkHX3cfeDACxrCbdo0hQu+WPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Date:   Tue, 14 Dec 2021 17:21:42 +0100
From:   Mikhail Golubev <mgo@opensynergy.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_mmio: pm: Add notification handlers for restore
 and freeze
Message-ID: <20211214162141.GA234929@opensynergy.com>
References: <20211213160002.GA202134@opensynergy.com>
 <20211213185317-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211213185317-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: AM0PR04CA0049.eurprd04.prod.outlook.com
 (2603:10a6:208:1::26) To AM9PR04MB8415.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5310963-f904-489d-f6f6-08d9bf1dd40e
X-MS-TrafficTypeDiagnostic: AM8PR04MB7842:EE_
X-Microsoft-Antispam-PRVS: <AM8PR04MB784265C9757614D509713D46E1759@AM8PR04MB7842.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fg3fmWPxqYU/jo9Eu0OQwGYcVtcewE55C/eWqUhxsCQpAbJeKF6c5R1+9nAUY+9/IHloQkMl1Ia0nCi/6EumT7z2ggDe32Z/5q6AXM1UarwxeYm4XtjjRuI+x11FmwHt3+Cllt5cpG5YgRwex3Dnp5uj82/0WkwhQD7yTzaxLc2hpbiz5G7Q1wEpuN4NwjW+8v+GLI134YdC2wxOLeZdXTnNhBAnWyIxuzQ4kByxPzrvs6rey6C01l4Mh17QNGEtZq9pRRy/8Nw0POS+5f6IC6s0ZIZ4SywEWVR/hSH2D2GLS/g7zUCmA88xBSKhtenPJIpBZME0OuJTG1K546EGSxoEmrBDfv8U31wP11G8hpU5OIcAQq3MqbGBXbtoL03yU2I0Mtrb6DO9vCZ4wA4Wg576/pI17vBLJH2wXE+OFHfqVECr4+gpDr4qmzDfa925aABU1HPls1/K2N1Y0PS8t7MGp+ps7/kDYh1KHnZB17SPPXnvzOzfHCTyRJyT2vVdR5nSZSqcyR0T88NJnoXCmdJVNcHnXe5exsg2f1h1SRfeso3206W8RB9xFZpoNd4niIBhOL7ilNgH514iOxOuOjIImOnQ6CFxNbjvhyuesYKKoX/BrneR8KPsBjDXQZTSSzSbHlus1z8COPhWv3zpbxI2qSlbIudLs7Q8llFKvGn06t4HBWVZvZtHZe5RvPH5hdmcE1wYA4OuMXksGt+X+cRhaBFgkLdxBydlEAYJf+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39840400004)(36756003)(5660300002)(33656002)(8936002)(4326008)(6916009)(52116002)(15650500001)(508600001)(83380400001)(66946007)(66556008)(66476007)(1076003)(26005)(8676002)(316002)(38350700002)(2616005)(42186006)(38100700002)(186003)(2906002)(27376004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3dXYjZYMUFLYWZoTUZ2cHorVlpJM1RlZEk5eXN4NFdIVnlVTnZFRUxJYW0w?=
 =?utf-8?B?U2syb05EUmVheDhLc2pZYm9Cc3JsUUMvejlBaktsdGZqczZlWFF3OTdvM1dL?=
 =?utf-8?B?RE5RYWNkS3lFMFQxZnVoWUVrNkJkdGp2ZlNoeExvK3dpY2NVS2dWRmMxRGww?=
 =?utf-8?B?NUNCMnNqdXJ6TU9FYVNQb3ZHNjVYRTBieFdINjBtajJ5QXhBbmhnL1VhWEpR?=
 =?utf-8?B?anRmTlQ3QVV6K1o1RUo0VFFFWG9vMi9jTmdrRCtiV1Z2em5tNmhOVE9QUTlU?=
 =?utf-8?B?MVB2dFJsbGNXQXpEUG9XQ2ZCbjFtNTJXZFFtOUlqQ2UrSmNaS2Z4ZVV5cGZM?=
 =?utf-8?B?akNIdXBIdGNLWWhXS01heDQvTkVTdVM2SGE4RGJsbFZObVNRa1A1WmtxUTN2?=
 =?utf-8?B?VElteXNnNUpub0JBRmlOb1pqMFhyeU4wWGpYclQvUEx0STg0OXVGejdKeS9P?=
 =?utf-8?B?SXFmUUlveTN2VUxmcTRrVnJWeU8yYmJlMmNhZFp4SDZsait0YXBnOC9wVjFP?=
 =?utf-8?B?T1NFTloxcDMrUnQ4WTVTVWZRTDRXZXlrSENrSHZxd2RPSW4rRE5ObXIvaU04?=
 =?utf-8?B?QWlOTERXSzNiY0VHOW03NkVEM09zeFNjdDdRbE42dEJRZjhDdTVRdSt5bXdQ?=
 =?utf-8?B?QTVaQ2hJWVYzdGhWVUI3UjhXY0NmVmtjeDFWVnc2SDJoQVFEbnZRMWFyUVcy?=
 =?utf-8?B?L2grb0dTNFpXRjJlWUx4QW1YaVBPTE1hWk5EWDZ0NTVtYlBLMXBOck5wMmRu?=
 =?utf-8?B?b3lUb3pCend3NXZXZlZaOTk0T1QyQzkyb2tVcmw3bUdqM05VL1psaitzRFB0?=
 =?utf-8?B?dTFmclFVRnYyTVgrMXNacVVQQVd2TG15Z2xMUHhjN0hudkc0MHV1U3BIbGtK?=
 =?utf-8?B?aDVLWlJVNFcxVjhlaWFTcHRtSVprR001MnBoY0t6R004THoyQ1E4L0JFTW5s?=
 =?utf-8?B?eWdLN0NZQUxnMGJNckloQ2hXMnZBN2x5OGt1WmZtaWNCaDFIVExaeEVSU3J0?=
 =?utf-8?B?dnNEK0dUOS9nMmJxVlJmREJwMmRvWHZvYU42UWdoSUJlL0h1aERiVlZzY2RP?=
 =?utf-8?B?N1hQQnFkNmxsd1FwdEsvemFsMEdTTUhqczBkUTVYMGU2czZPTzBxRXROSThF?=
 =?utf-8?B?NlFuSEhuZm92ZXRxTjZtbXQzMDRiVUJ2cy94a3R6UGlTOU9xdXFEQ3RuNlgr?=
 =?utf-8?B?ZDBmaXJTRHpzRGtqcGlDNlpKRTRncnNnbTM3TjNsTlpZUnNKTERiRjhIOGdR?=
 =?utf-8?B?UWE0Qks3eWZITTBPeDF5Zm4xZ1RHeDlXdkUxQ0xGMUx2Mmp0Q0ROMkt4Ynds?=
 =?utf-8?B?OWl1QWZBcEQ2L0c5Y2l0ODBHZU9hcTZ4elk0ZVN2ZHVQRDdjWVhSWVk1ZlJp?=
 =?utf-8?B?ZkZWZ2ZjcUlKWmdFcUIweW5CbTQ4Y21JSWJ0UVl1aUxKVU1PbzRZYk4yZU5j?=
 =?utf-8?B?dlArUXRPemFkMTV2Zlc4a0c0ZkJYdEdzSVg2NXBST001SmZjbXEzSUJteHJY?=
 =?utf-8?B?R0RnT0g2K05wbk5MWHRobit0endENnlEbWhsaFNldS9TYjd3RkU2TDBjSUhk?=
 =?utf-8?B?bGZSWFpBVlNVSmxOVnl1Z2crYjk4U3ZjUlNrNHUrVEQybUIxaU1PUFVuUUZR?=
 =?utf-8?B?RnB2RnQzQkV0UituRVFweDM0QXJLN2wwMnRLVUJTdnFQdWdOdjBoemVkV2h6?=
 =?utf-8?B?bUp3WnRWWVJES2J1TGZCeENsNlBsQVQvR2hjYmdTS1FOb2FpSTJqTW1RZ2Nk?=
 =?utf-8?B?YTMycURHeGp1SllwTG80b3l6Y1d3U0p5UmtpZzlKSktHQ1FjSTZvbU51Q09O?=
 =?utf-8?B?b0JDV2YxM3hUbmpCQStJK05GWFVRczlqeGd1QnU5a0wvMzBZSXBpOHR1ejBD?=
 =?utf-8?B?U0lZU1J4T2JwcHlXcTdsOWo5ZmpuMnd4dnQrS3lyWjB5OGRsUmFYTnFkRzEv?=
 =?utf-8?B?bnNQNjZCQ2pxNnp6TEp2REwzRnR6aXRwWmRaUGhjL3Z6OEMvQkJ4Sm81S1dt?=
 =?utf-8?B?M29QanF0Vkk5anFjeURpSXpTQXc3VGtrd1BTekZuRXpXTjVFTWdSVjA2WTV6?=
 =?utf-8?B?dzRFcmoxRS82cldQelpxdkh5d3Y5dk0ybXREL3pqSm5UZ256ZFdBelhIUWRs?=
 =?utf-8?B?NkM3LzdTbDZnemdPRnp0aWVvdkpPemtoRWs3dktlWUhtb3Jxclc2aDg3Q0FQ?=
 =?utf-8?Q?scetlgtol/qlgZi8NR6Ti9g=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5310963-f904-489d-f6f6-08d9bf1dd40e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 16:21:48.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5jgj+dY/I4nIvpqBdSCD/DvGt8ZHR1yB2K++zH6zR2DNMvhU3zxg/tLsOmNiuuohxrSsmeAmXe077FSJtIQcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
X-TM-AS-ERS: 104.47.17.173-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26590.001
X-TMASE-Result: 10--9.385200-4.000000
X-TMASE-MatchedRID: csPTYAMX1+HmLzc6AOD8DfHkpkyUphL9EttPyPqPL1ciwdV2PnLzImKp
        MJoimBcbrk72OlyJnm1ehbG5gR/GLxh9ru07UZ3fPwKTD1v8YV5MkOX0UoduuVVkJxysad/Ie1U
        dTGq1a6e31RJTt3dmC+m0y65dh+wntKK2P+LRq7v9xyC38S1f/RiDIOPlOJG1tOLHigXWIjk+ZZ
        vlQwSOBDkll3ap6XPOQJOohUzXPHuXBXaJoB9JZ4MbH85DUZXy3QfwsVk0UbuGrPnef/I+emj+9
        OQ3tg38PbquHkNeTN4b0l6gBx19mCcaXLgWufACr2a15/0+H5s=
X-TMASE-XGENCLOUD: 77c07096-e7cc-43fc-8ec8-1619dfc14b4b-0-0-200-0
X-TM-Deliver-Signature: 216BC73255388395DF8A285207215352
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639498909;
        bh=NPmZTjhb5qhvVIy+zD0LJsU35qF/zYubcGgoYbVWf+g=; l=2294;
        h=Date:From:To;
        b=ymWYSqZON9sBj/GX7wKDRH3VA3qRcoHm5MoUh+UceRCphKBFyNumChVEb2nu6zOHP
         jr/U5vUgPUpCpldNY0U2+a+eV1p3eYIEt6/G5vc0/ZuMAnk5v1v1pcZ+Zc4dWjdAtM
         1F5v+YDA1ClXG0eeRDwDZBBOQlfeAxcstumlaIcw0nlQYnM8CXn5C4O2z6FVzdhf89
         v87Lzlqcjt+z9JAHz5z/Mf9n6IOHj56g30PjLcjCiMKCee1yvdAgngHiPxyLpQ0+fB
         70DcqRGDovqZ/eaQ4S80k1lSIWRjkx2wv9OR7VZNGv1kkaxXRq7NRc/Nz86f1+otVZ
         bhHGzpPY7QQPA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 12/13/2021 18:55, Michael S. Tsirkin wrote:
> On Mon, Dec 13, 2021 at 05:00:08PM +0100, Mikhail Golubev wrote:
> > From: Yurii Danilovskyi <glyd@opensynergy.com>
> > 
> > Handle restore and freeze notifications from the PM core. Expose
> > these to individual virtio drivers that can quiesce and resume vq
> > operations.
> > 
> > Signed-off-by: Yurii Danilovskyi <glyd@opensynergy.com>
> > Signed-off-by: Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
> > ---
> >  drivers/virtio/virtio_mmio.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 56128b9c46eb..af79f8c2a2f2 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -762,6 +762,24 @@ static void vm_unregister_cmdline_devices(void)
> >  
> >  #endif
> >  
> > +static int __maybe_unused virtio_mmio_freeze(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> > +
> > +	return virtio_device_freeze(&vm_dev->vdev);
> > +}
> > +
> > +static int __maybe_unused virtio_mmio_restore(struct device *dev)
> > +{
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
> > +
> > +	return virtio_device_restore(&vm_dev->vdev);
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(virtio_mmio_pm_ops, virtio_mmio_freeze, virtio_mmio_restore);
> > +
> >  /* Platform driver */
> >  
> >  static const struct of_device_id virtio_mmio_match[] = {
> > @@ -785,6 +803,7 @@ static struct platform_driver virtio_mmio_driver = {
> >  		.name	= "virtio-mmio",
> >  		.of_match_table	= virtio_mmio_match,
> >  		.acpi_match_table = ACPI_PTR(virtio_mmio_acpi_match),
> > +		.pm = &virtio_mmio_pm_ops,
> >  	},
> >  };
> 
> All this code needs to be within ifdef CONFIG_PM_SLEEP.  Alternatively,
> tweak virtio.h to expose virtio_device_freeze/virtio_device_restore
> unconditionally.

Added ifdef CONFIG_PM_SLEEP in the patch v2 for simplicity and to be more
aligned with other PM code in drivers/virtio.

> 
> 
> >  
> > -- 
> > 2.34.1
> > 
> > 
> > -- 
> 

-- 
