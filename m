Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25D6475F56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhLOR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:29:51 -0500
Received: from repost01.tmes.trendmicro.eu ([18.185.115.5]:59557 "EHLO
        repost01.tmes.trendmicro.eu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343869AbhLOR1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:27:50 -0500
Received: from 104.47.17.169_.trendmicro.com (unknown [172.21.200.248])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 2D57A10000079;
        Wed, 15 Dec 2021 17:27:48 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1639589267.883000
X-TM-MAIL-UUID: 8cf8a7fd-3181-4e20-8b63-41c37a153794
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (unknown [104.47.17.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id D7ADE10000301;
        Wed, 15 Dec 2021 17:27:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0LjV2K9wGO1wYFHmVt2fMfXsd6X3GfzFYFARNGlw5E3bmpIl+HHuy447A2kXJoM6GCt46qKE08S+mBkkkUG3NPSFUHPo7nvQC5S3CGq1RA39dGblcQTlwTT5Q2PsGyWJPL2T3pJu9YbGxsRpCGH40WgVvgeWwMg4pJd8tWgQqR2BIatdsg6UcvbMTy8rhLzdQBsPUoE05Mp7aWFwvdpEtCmbQ5f0SKR/TxKYmiy4+oKM2o6zpYr9xDCPj6j8Zz9x99yIP+xjMLAyQBoPIGjqwFPb5tpUti9/TTDETXVHxmopM118LDV4LkgaG1uF0LAAFiB4Z4axWS1aI/XVVudVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mg8WYyksUnGtHW9hdBrMc7FYnI2vwnGLMUUw21ZGmQ4=;
 b=nAEEc3rZ7VZRcERDlo6b1/7eqTgOiHa8s8fxAl4qU9/JKL3I2KCa+EL80XIYQgS7q7onvf28veD3t2RWNAyAVYloHCn488ZR29ZtXmgkszQc5LRa93UNEyZy+Ax3po1cAjvoZBQZ43QwCjp7x2npIKKdKuOD8TcMW5xvRqcD9+Jbtz1CzxeupDpbAM0xu226LX1wLB7mKri8ugm12jjo9gtHSOxpcT6VVBOTQlbd/ePaqPVPTBqFSEjlfcKUuSqwZDvUTFJueShe3SOsdqikH5omd9W/1URv6CR6B1tMzzAOuU1OaQX2b/Doevb23rAMpx1QnEn4Z2zmIb4RypTc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Date:   Wed, 15 Dec 2021 18:27:40 +0100
From:   Mikhail Golubev <mgo@opensynergy.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
Subject: Re: [RFC PATCH] virtio: do not reset stateful devices on resume
Message-ID: <20211215172739.GA77225@opensynergy.com>
References: <20211214163249.GA253555@opensynergy.com>
 <20211214182611-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211214182611-mutt-send-email-mst@kernel.org>
X-ClientProxiedBy: AM5PR0201CA0002.eurprd02.prod.outlook.com
 (2603:10a6:203:3d::12) To AM9PR04MB8415.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff2595b-3738-40ac-09d4-08d9bff035f6
X-MS-TrafficTypeDiagnostic: AM0PR04MB5972:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5972961781016D7925ADC5DAE1769@AM0PR04MB5972.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gENkcFXBnF/GBsdBjxo7NTGHjecSyDs/mI+64w9aVDu4Ouce1WTShL7dhJn7AKZnicuvDepEspZKF/wG1n7Tk9yxuYD5i3egaaU46mOCEcrwC+lyT4eP1waUIsKqBNeWPxhZHIBzZ4VKd1nfYhoogj9OpNmIpmJbT/J5I5Wrc6q7jEwEQGhJtZ//dDHYA7BapjqGMJYiPCI0dyvCLBwxpVoffy4eKcVjJCzShywFJypUsNRXr9hHA60MBMzgOk8rPFijgg+tiKtwFSqCTVGTIqaoNVQ0FQ76e73N6+mvhh74GL1TWB2JZvABSGG/z8kqXK/Mqu+8mCGiPwzSGvvXeRtQ6k8W7Xv0G5TxFvK9UNZX73g+G92HETxO+pZjF7bvNh03TP+Tq6Km6bY5IACNIWgyWv+Zr6kH7a5cYCQmMh3rDQh3rIGav/fsmxKGG80hPPHkU5yM/FABINh4dqpE4N31jsSu7uo3SKScLW5WWmFCAyJJPZGoSSns6z0vAHqwKL1SNERhsiPTR52rrpd1hSzIFKrWiM9No7ekmn6RJmypMLcdLuwDRW8sfy9owGAaK/SBTwLyihVRLQsGGUunqAkWzv6MSqO7K9RZ2midEXWD9vSWD9SByWf9fVmeNBSCcSbly+wEF8xkkKzP5H672AbVWQVo25B054MP2AG3Mj7RCVvsL5BFLMqL76I6OG8RWSd9maKuHz9aeg8aLqHiog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39840400004)(366004)(66556008)(2616005)(66946007)(66476007)(186003)(6916009)(83380400001)(52116002)(54906003)(316002)(8936002)(42186006)(33656002)(5660300002)(508600001)(1076003)(26005)(4326008)(2906002)(36756003)(38100700002)(8676002)(38350700002)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGNBMnE4OUFzckFFYTMvNHpDVlEvUndRM1p6RVIrczl0SUo1SmM2eUhDbWN3?=
 =?utf-8?B?bGpINUZuZDliOFhUQTVxSHlNbXkyd0lSVlRXcjQwT2tOUkJ2dzl2UE5uSWdx?=
 =?utf-8?B?RFZYMk9obkw5M2p5eklYOVZ5NktFZitvSUNBWFZ1OVE2RXdidTVkT25GcUJZ?=
 =?utf-8?B?d3JTZ09MbnlFV1VHa01aTE5XUWZrbjVZUUdWVUY5cjRRVW1qa053M2kzcWRN?=
 =?utf-8?B?bGw1VkJyTSsySnNTTlZaVzRwQjl4ZFh5MnlyVVRQd3lLZjhndW1FSDVMcndm?=
 =?utf-8?B?dFVpOERsTmE0SC9abWFiYVZNUGl5VCtZS0pNdWQ1YXFFbHAyRElXbTRMSXlO?=
 =?utf-8?B?YkluTDdwSVBTaDFiVzQ3bm1hb3hCV09UamNUOTMxVWFXSmRKL29pZ1R1Vk5X?=
 =?utf-8?B?Mm5HaDFFOTVpSWZYeWFPdGVzY3VvQVBlMXZ2NitxREdQckZsZkpUOUtudE0y?=
 =?utf-8?B?T015TjdLY1RpOERpeWdra0k3Z1U5eS9DaUNuTFJET2lxV3Z4Z1BjcElBaFNr?=
 =?utf-8?B?MzBaM1RKSWd0dXA3REc0OVdvcER6Y1k0c2k2V25zbkFkdWxxMnJwaUR1dDhr?=
 =?utf-8?B?aGRpeVV5cUZZL280RGJxV0lyYmpIQnNacWxyV1k2VFJWbG82MGV4S2Vramxt?=
 =?utf-8?B?Q0dVUm9KK1ljOUs0ejE2QkxId0taOTlZQ1dxazNyaEhjNHBISEdYeWxhaW5D?=
 =?utf-8?B?aDVnNCtybjMya0tPdm1Qb0RLZHhoM1hjQmlEZXQzSXB6cHZzK0V5MXIxNFJl?=
 =?utf-8?B?dE5oSW5FMWJXbDJaMy9KazBYQlR5NFdMUVdZZy80M1ZJWHpUTnJsaDFtM3FG?=
 =?utf-8?B?ZWI2VE55Rm56N1lNaFA5dGVnekc1MkR1V1NwQXUxMGdxT0M1UDJsdGloNU8v?=
 =?utf-8?B?bzhsTXNKaWpFUWhJeDJOYWw0U3diVWtobUVrcXRjQVA2RDhxN2NETGtnUU8w?=
 =?utf-8?B?NkJYZ1dhVTA4UWxSaFo5bXlmTXB4WWRWS1lhRGNFQmlyQkNsVlF6aCtSOGRj?=
 =?utf-8?B?Yjg2bk5Zb1lIWEpFaE4wVGplT3dwV3BMaHVpRnJPZnRVZXNjWkt3ZFIvQ3B1?=
 =?utf-8?B?KzJwOVRYS2wwU2ppR3hCTzNrSFBOOTFiTEZDc09zOEdyVHZ6bXIxWFVBSWRy?=
 =?utf-8?B?RE5uSDhzcDBaWWs3WmJyL3NtWnBpNzBvUjNJV2JCWXp6MGJEdEM0TGJjOWVZ?=
 =?utf-8?B?Nnc1Y1dNdW5IR05PeFNqRGRuVVowT3pQb3lYZ3Nvb1E2T0tETG9FRllFdVd6?=
 =?utf-8?B?Nlk0aHh4VVV2S1dZOW5KRER5Z1M2eE5oMWVtUGpBVDY1dDV2NGc5R0NsVmpN?=
 =?utf-8?B?NFJnWTBBMUwzSjN0c1BNd2NiMStFZWxuYktUemZucG9HcTcwcDFPMHJOdlZh?=
 =?utf-8?B?c1oxY21CWHRPRWNVNVZMRjNLRkdSaUR3TWdlNzJtcDduRFFHRmhRNS95SWNF?=
 =?utf-8?B?Y2t2R2lsYmJGWExVQWhGWWlDbkw0TmlpUGxUbWtSN1UzeDZ1TjVBZVpxazdN?=
 =?utf-8?B?YXJrOVM3N1Zrc3ZHdVhjWEVoVGZZZGR5K2ZIbFBBZE9wZFZkTndLeThnazRt?=
 =?utf-8?B?VEsrTFFtSk1qa2FoZS9QNXVqYUswQitLRDNIWnBSVUYrZThnSTlxVHdIZ2pa?=
 =?utf-8?B?cFlCN2t2U1F0czFoNDhYOFNnWnplNjFUVExzNkpIcVJGTkJWWXJVWlZaSm00?=
 =?utf-8?B?ek1UUXM4STl0TjRHOS9YRWFZd1VYVmNZYnFkOUFnUDlDckVkc3BCVzhsWVc4?=
 =?utf-8?B?VGZnYmQ3TFhCTkxwZEo2anZoYUZoV2FIaU8zWittU1ljZWw1czRqSDVjMlBo?=
 =?utf-8?B?dk5QNGc1LzFPa0NUWVNWcmhuMXFuTnk2eHNIZUhWWWNOZU1JdlRuWWRtWml3?=
 =?utf-8?B?MGxoSUdBWTBkTjRrVHV2c1dTVGJmS2NDWGt0cTRIY2pkYUJQcG04dmRvUUdu?=
 =?utf-8?B?RFNrOG0zK1BEM0RLNGZKd1FoL0lXeGllbzBjWXZNMmxIUUpUb0w0US82VTZO?=
 =?utf-8?B?RDRqMGtKdzVTZVk3NFBSQUNwQmdzSzk1Zm9GaHZyemQyOWZnbmJ1Rmc1anU4?=
 =?utf-8?B?cml0cHdoeXZJRFB4bm9SM0liUnFZQjQ4V0c4TCtvd0JaTEVXcS80RzMyeldw?=
 =?utf-8?B?MDFxeTZyV3B3MHgreUtTVjdKdVgwT01jUFg0ZkZVOEVBQUovdEsrb1JnYldH?=
 =?utf-8?Q?iW1SAJ73cDAkj5mbxFPgH2U=3D?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff2595b-3738-40ac-09d4-08d9bff035f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 17:27:46.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7dbQ6FVWAnfkrTRXAgDYTmQYfPDw8SjqXYhMX0MG7ZJRLhiDO0fjPO22S4tCdEWAXRJlBNX+DTN6cvWKBDhhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5972
X-TM-AS-ERS: 104.47.17.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-8.8.1001-26592.001
X-TMASE-Result: 10--3.343500-4.000000
X-TMASE-MatchedRID: QfHZjzml1E/mLzc6AOD8DfHkpkyUphL9Y6cKHJXjZfQXe7HSQI7bqeBQ
        gclcrHbyRpkVh7ygZ78W/v0Nb8y3QIIpCnvqEx9h1bFtmBqqFLQUCv7A9Z7uMauPvo9L6iaI0DZ
        ctRGrjM2J/MueD7qyY/xJpelXs/hKe+B5qjvzEpGa+cpJvTbSHHqLr3o+NE+IB2QWi8BF5SiArq
        oIZrVn11M+OAmVuJqc8U03LjxmCxI7mT8/EEC+/iAI8aJmq0jwYM9s6twyNwm2RedZ1wo4yAkAB
        IzUftuc6BzqZfWXA0dftuJwrFEhTY2j49Ftap9EsjvNV98mpPPUawjRn0lwXvQl1QnIuqLKKhaO
        m9bRmgGCeNBRVuOOzRPFGoewBcuuftwZ3X11IV0=
X-TMASE-XGENCLOUD: cc2de67b-72e1-42e6-9d3c-7712ff496c68-0-0-200-0
X-TM-Deliver-Signature: 3D3AA2A75339AB37C27A3ADB16625115
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1639589268;
        bh=ztQFl3H9XmUE/Im2MvdbU+aKZA5+MYSTI8JppUtLwoI=; l=1976;
        h=Date:From:To;
        b=buN5T3f5pn0by68sjc6Q4T+i917PAHb3ac4+Rf0gpHbg3yLnGqOmn5NNlB56MRW6x
         7+5qLQZZMdY0w4ZJldZk1BZZBjD9LriKU/a6ycgfTsBbilr2ubGCP3KSozL7CR+BB0
         Epu7sPUXyVP3an2hL1WPJwnmh+nYoa1mXXqYjPUlRmMdtSnGEJQLGai8Y3/eetOhBl
         hjcIGHA4xNaOOLzY+qEKE9UpauEwQ5ATVFVpgQ6DltSsex8BHflMZ00zlvZZ+bBCla
         LNauX9xpe29JrSNrQTQTQ42wlNR3/9xljuZ6Tl/oN6gNl92/HPtPFUAJav+FfJzPia
         ngGrHp0IcOC7g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 12/14/2021 18:26, Michael S. Tsirkin wrote:
> On Tue, Dec 14, 2021 at 05:33:05PM +0100, Mikhail Golubev wrote:
> > From: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > 
> > We assume that stateful devices can maintain their state while
> > suspended. And for this reason they don't have a freeze callback. If
> > such a device is reset during resume, the device state/context will be
> > lost on the device side. And the virtual device will stop working.
> > 
> > Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> > Signed-off-by: Mikhail Golubev <mikhail.golubev@opensynergy.com>
> 
> A bit more specific? Which configs does this patch fix?

We had encountered an issue related to 'stateful' GPU 3d (virglrenderer) and
video (gstreamer) devices.

BR,
Mikhail

> 
> > ---
> >  drivers/virtio/virtio.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index 236081afe9a2..defa15b56eb8 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -472,6 +472,13 @@ int virtio_device_restore(struct virtio_device *dev)
> >  	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
> >  	int ret;
> >  
> > +	/* Short path for stateful devices. Here we assume that if the device
> > +	 * does not have a freeze callback, its state was not changed when
> > +	 * suspended.
> > +	 */
> > +	if (drv && !drv->freeze)
> > +		goto on_config_enable;
> > +
> >  	/* We always start by resetting the device, in case a previous
> >  	 * driver messed it up. */
> >  	dev->config->reset(dev);
> > @@ -503,6 +510,7 @@ int virtio_device_restore(struct virtio_device *dev)
> >  	/* Finally, tell the device we're all set */
> >  	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> >  
> > +on_config_enable:
> >  	virtio_config_enable(dev);
> >  
> >  	return 0;
> > -- 
> > 2.34.1
> > 
> > 
> > -- 
> 

-- 
