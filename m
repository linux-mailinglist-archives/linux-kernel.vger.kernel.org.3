Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB47055B587
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiF0C5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiF0C4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:56:52 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2129.outbound.protection.outlook.com [40.107.255.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4D73897;
        Sun, 26 Jun 2022 19:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4ytobRh4J6suXwFoWR1SaMCElYQY3QLflafBErBI/Ek7LdyFo8HKNUoeAnHb1pnYLNvhpCtakzJDUT/QkGbN5nj8auvFsY3BndSKKGdfk8F3/zzdcUf12xQse63uLzBHesY44Al5k02QutLgI8xNZvwYqTO+WeplFvlywcmr5BiVB5mNheIhYhu4SagTrrLym/Ug0BNEHW1ChBnMQ6cD6x2l+ZhiLKKXGgPjB5XnXP2W+a+ddMlXVsv/+FF2Hpef/zWchGfzjegpX8XwNRMzKPSp/YJ1Hc4FMOTn09BYjlSGIzvuL24qbaSM/fnBajeUFj4xZ91ocQD2zIesHI4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQ49xSlZIJPTccrfMzZGzPdatXmrn9asRWER3HG+LzQ=;
 b=D/qwyUF8aWZX9i8z9JOc6BooljaBe+qkSsvNoogEvP1tC4DqQFn92EdnT6jhcTCOSB2bDjdsgCX789HTdYHIXN8u6vxVlzGhggoCkgqR6YyG7lXu0u0L9GCOMyT9Z1+Pb3gP5tVXI6cyu4jDI+s99FCwvkLQBhhqMJPfogzmkPfIi/ekt1fE5lWXWmn1t5HvnotGO+SeTkSZFLhLUkO08pXaBbYDYtnwYErgmDaezze7bkFyXkQlBZosu5dYSmFKH1mZSYtdobI4yK9QAxRUipv59QMWWBb+R7DxOkHv4RdDTs7aK+3pkgk4abKjTfpWlmmTo+zQ/S2Ol3x37WdeBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQ49xSlZIJPTccrfMzZGzPdatXmrn9asRWER3HG+LzQ=;
 b=Ju9Cb1pVrNCRAimn+c+L3r6QEDH+eBWwGzcft44WuhGFvp4O5m6CZX4FSweyRbdak5qobcXp4ECREp+GWXYo9tM/BtXj66bNYd/5V2Q9lN9BN3Y97/GZcV4hnHXssWF+gF7X+fpAa4vPbiWjL0RlHZ75IaiMNO9euCsjIBFLr3sC40dsR0l8Rtl7RCciZ8ttJYlEXL5ektah1/HBE3IQ5STJrgOIy/3E3aZQ/hjrTcQykeE4hf78NZeI5ao8NdK72g02mPfKE+y6myj6scG674+JvmjnjhmYjAhMNU0by+6FnNICUomCzopmrv1CkASgxQDH/OoOrb854Y/tTNw4NA==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SI2PR06MB4460.apcprd06.prod.outlook.com (2603:1096:4:158::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Mon, 27 Jun
 2022 02:56:41 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 02:56:41 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <roger.quadros@nokia.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Topic: [PATCH v2] usb: gadget: f_mass_storage: Make CD-ROM emulation
 works with Windows OS
Thread-Index: AQHYh3DSTidIVUKmfU2+k/4XOqVQ6a1engoAgAPzy4A=
Date:   Mon, 27 Jun 2022 02:56:40 +0000
Message-ID: <HK0PR06MB320272ACB1CA4ADFF8DDABC080B99@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220624021916.318067-1-neal_liu@aspeedtech.com>
 <YrXJss4cTtfenu90@rowland.harvard.edu>
In-Reply-To: <YrXJss4cTtfenu90@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df87cdd0-d391-467a-8889-08da57e8a947
x-ms-traffictypediagnostic: SI2PR06MB4460:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h6Yp/w1NQjuUGj+70oQejAtFIWrkmka3UtdLehdTr4B35hKNtMHwJKrRmbrOoteEav+AxWAbjAJmWEwd5l8g8yWNo4Sxc3/dezS3A2MzxGW42uVfLLILUlK3Nh1bO1XGKv1McEXl+IlfKKZUBQ7uJzgjy3pq0qYtjsIXD0F/XRjP+7k9UcuwzcpidfIp7QgAG1GS4D2D03nUY/pOvf5/y5+/f3TgM18yegu1+dmLOfVY+/HXK4WUjhrUhMoFm7mDyajjzHdJY/aWdCygMECAWCoPxqIoJXgpSIJGmvMptYoeuDJJDoy9KRSgU3m2YbEW6wUYHmHSj3nJPLYWdWR3c2EyLDCalS1xMNESzGkJWC7XLJVK7o02trmSYpqImlSs37VgoXkx5QZvPEkCLfxVcEIXidrO3tkWFTA9rlPxuxkyp3hGqJPJHS++QaLNVN9LERMrDlgH5/u+lBXygKe+yxcMIm95xOtOASVYFA+nY11vrm3/cPHOO+vBS1/hAfcHCAyTWm3CUmlTp3vtD8e2hwS+gAqG/OUaC7J3I+mk1hPaca9b9YyzNe96pBgv5yZUjY5cTrxpDQTfbkiGSugfehCkLk+JYbYxkhmxdHrYnjSNGWl/wb4g+XeDJjTlcPlwIuHk7acq2XqahBL+0ee0oTw8kOAFRBS9npO+4zEwPrrsuOL/l7CiRXwUSUIL7tQGT8ZUvHmyn37ws91jkfvpbYZYCsotNdYC8MrjGylRE/43YI52uAmSwRp4zh+eVMaI/hjOFF16hynV2LbYuKWtqYdO7y8rlgZ9fTQn0AHE+SU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39840400004)(376002)(396003)(136003)(346002)(366004)(41300700001)(186003)(26005)(7696005)(83380400001)(8676002)(6506007)(107886003)(9686003)(6916009)(38070700005)(38100700002)(55016003)(52536014)(33656002)(4326008)(66476007)(2906002)(5660300002)(7416002)(86362001)(478600001)(71200400001)(54906003)(66946007)(66556008)(122000001)(316002)(76116006)(64756008)(66446008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JPuCAIT8+/l4Y7UawCr7lWzsf0WHNkQBCEoUvsLJXEQWUa4twXSTpFlRLXzF?=
 =?us-ascii?Q?FVoyMRA9p1OGnNCX1LruOXUm/SjhZ+JQi8VDSu0RB/dYPSctpWvkpgmWphkG?=
 =?us-ascii?Q?pqQ6Qrz4KsWXFwX+NNDgvtYBPRBREora5FUTuJCXA0VnhJRqZ/m86t3FnCWO?=
 =?us-ascii?Q?ZwAKJVBInayOfdzPyjjXaL+dMESrR9TN+QluKxnjw9sKfttHSm0e5mKY76C9?=
 =?us-ascii?Q?jbgMJ8ERyI3xPtQwW/rMNf7ubBxq1vk/BL0sYx7ZXE85M1pZHbR4+mUeCboN?=
 =?us-ascii?Q?kv9HlbexxzAptivrZPRL3OMUwkr3t6u3edkIMOsVUB2QgR41c1OFxqhuxiVS?=
 =?us-ascii?Q?d4a3D67kONzwfgaZvXQf3gLGxZqfoG2aeLS02KmmdGF3rWgC1Rlr+nPxLH4V?=
 =?us-ascii?Q?NQOLThzABg68QQutqqTFM4bebSkvZAfyEgrgJqkCAF7rb8jMxx6yzXBefJQn?=
 =?us-ascii?Q?ElSFWRAzCze6+x4hYmVPL3UwjqFeyZP9FAWNbgI/IcHlB2vfKOjk2deklvGY?=
 =?us-ascii?Q?G/vfKtV16fcG9N5gZFs87DScsukwmQwS1UpxrOLE0+Y0k0QECCGj9NCtf6lS?=
 =?us-ascii?Q?glqQ+NWrlPnrOFk0h1Cw6CKZGaJKCs1EegDAAUTU3n319JVFBW7ZY6AMaHuV?=
 =?us-ascii?Q?IaY3zmsUeoaeyV1GeODvNHqxl95XFlENAF8IdjOmRD9wLIkF0crtpKgr7mF5?=
 =?us-ascii?Q?I6xahvR7BHoWjqBY+p7e5E7tHcQeG5xa1iV+D+j3X78Ga4JXZD3Z2QZYihTQ?=
 =?us-ascii?Q?cHKEwwjzGVvX7pw35gmy5b7SD7gNzmuENudo4nOhQ0T4MuitaCI1YYFlvSnw?=
 =?us-ascii?Q?zznoToG6snN+j5Etf5d7KTTAHQ/x98YVsfK7C70wmg6caa7iQ2wM3b1Li/7t?=
 =?us-ascii?Q?7mgXHlB25Hr1q/2r2PjXZ26YYx1juuhzuIwmtT1V7nmLGu8sUX8D/zsOf/Gs?=
 =?us-ascii?Q?GUhgEtx2R6/IZE3SBPJRaVXCV8GKbSpj8S0aDNC8BKNxZAhd3BN6sEU445kN?=
 =?us-ascii?Q?L9SBKkGj1VasZuLaCORZtsIBmCOfb4TzcYsMAXi6QpnLgOV9BXB2ajOfJJpe?=
 =?us-ascii?Q?KejqMFdWr/UmBwZGZLCpQtoGUAlGc2GBVcTqLSickDjecJbq4Q2lpIfI0Ps5?=
 =?us-ascii?Q?hVIIJOknMGaS0Ndgp+m4GCv7plaSquPwH2N/trDzv+B54fYQHXJplWkfRCaH?=
 =?us-ascii?Q?bz0cshZbPF8gjqZqAgoZMXHIPd2jtsF5sl3tJkcv/uGHj7BDRARGOok09XHd?=
 =?us-ascii?Q?XK98nptSTdfO/PfO+pce4n2/q1ChWP+ibX6Jj0VlT8eFKRQTfuNx4qOYTsXQ?=
 =?us-ascii?Q?TUJifWcp0TE87mDcZI5m7ElmqzB8sOfb7EuSvNOp0jht4Ae1ss0kIk158RhY?=
 =?us-ascii?Q?YdbD57nYc7v1GdkW4IfDRkABGH3+dRx8ND+aSzIHJDllOOrHwfvSnTnfRPTl?=
 =?us-ascii?Q?Rl0421Qj7nmkji8QYkCYZLuWE47vg3PbIU2QjacOUH7ySNv6RHDHQMQ1EcoH?=
 =?us-ascii?Q?SAGbP7+fMrg04tsCrEArI4iceqYXoYc9BUTzwN9gI09DkQ+HWLRzz2TBml/1?=
 =?us-ascii?Q?FKiYaWb2q6XHqOvPfTI4AhDzNQP/1fBeA/a6p8or?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df87cdd0-d391-467a-8889-08da57e8a947
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 02:56:41.0256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVznq7sSWnfwqeqaHv/erq2FO0KndLiZUgcSxq5Txmg057pqrf0eo/T7EePfk1bHMeripGuKXJpeKgoxPOU0pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Jun 24, 2022 at 10:19:16AM +0800, Neal Liu wrote:
> > Add read TOC with format 1 to support CD-ROM emulation with Windows
> > OS.
> > This patch is tested on Windows OS Server 2019.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  drivers/usb/gadget/function/f_mass_storage.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_mass_storage.c
> > b/drivers/usb/gadget/function/f_mass_storage.c
> > index 3a77bca0ebe1..9edf76c22605 100644
> > --- a/drivers/usb/gadget/function/f_mass_storage.c
> > +++ b/drivers/usb/gadget/function/f_mass_storage.c
> > @@ -1209,7 +1209,8 @@ static int do_read_toc(struct fsg_common
> > *common, struct fsg_buffhd *bh)
> >
> >  	switch (format) {
> >  	case 0:
> > -		/* Formatted TOC */
> > +	case 1:
> > +		/* Formatted TOC, Session info */
>=20
> This comment is a little misleading.  0 is formatted TOC, and 1 is
> multi-session info.  The way you wrote it, it looks like the comment appl=
ies to
> both formats.  Do it like this:
>=20
> 	case 0:		/* Formatted TOC */
> 	case 1:		/* Multi-session info */
>=20

Okay, looks more clear. I'll fix it in next patch.

> >  		len =3D 4 + 2*8;		/* 4 byte header + 2 descriptors */
> >  		memset(buf, 0, len);
> >  		buf[1] =3D len - 2;	/* TOC Length excludes length field */
>=20
> It looks like you ignored one of the problems I pointed out in my earlier=
 email:
>=20
> > When format is 1, the driver is supposed to ignore the start_track
> > value.  Your patch does not do this.
>=20
> Please fix this.
>=20

Do you mean ignore the "start_track > 1" above?
Do this check only for format 0? Or format 0 & 2?

>=20
> > @@ -1250,7 +1251,7 @@ static int do_read_toc(struct fsg_common
> *common, struct fsg_buffhd *bh)
> >  		return len;
> >
> >  	default:
> > -		/* Multi-session, PMA, ATIP, CD-TEXT not supported/required */
> > +		/* PMA, ATIP, CD-TEXT not supported/required */
> >  		curlun->sense_data =3D SS_INVALID_FIELD_IN_CDB;
> >  		return -EINVAL;
> >  	}
> > --
> > 2.25.1
> >
