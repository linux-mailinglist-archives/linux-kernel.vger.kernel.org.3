Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2722B471121
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244430AbhLKDO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:14:26 -0500
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com ([104.47.58.101]:36493
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235171AbhLKDOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:14:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcPQzT6pCg0mD3+MZfiZgtnQya06SrHHtFy9FCDt+8WTYkpJr2KJYszZx0tBwzF6Z/Lk2SQsC4FWvnK9YMKCSkWgrd6LjKcTdf7RfHjXih7IZA1zXyJFpRMgr7kJ82bey+Onxu7eEKK/LKrEvV1qBMG4gNcBLpgIpbB8ZCgvAYhn+QUdyyGtYJ6xXgLBdsicadZ+gBh6eVOPhdapMgZwBSW1V25MJXGJ6PrAPEIwK+ysNVzRG5H4BACtoDg/D7iy3mRVDaU6kP64qcJMaomGpi5YT1yV6Zjv7eUrZCKhy2f/JBW1sleGynSrZTlSu6g251QSBcuo/zVnG1yvFZ+tPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqaSOS8j6nuZ/WPJrNzkP04WKCQvjqAvOYGLTeMee8g=;
 b=fK7BG2+xdYcoY+tJgfGLkj7hJ0cFJzx/UvIwBeufs+g8Kk/Fu4JSQ9waD5Bz6bGoY1XfznfjNDUtmyszJHqDDXZCfBK7UHKC8ugsGfKXSkppp6K1BKfZV2CKHu0j0X5eQ87NfBG+c4zgrSy214j4+nKktV+zkWxayeCCk46QxEINeywm6LbChrp8U5SjHHVgtMCHVXkMKnAnVSYxXUVvZjCURQGxvgafONfAbkec7c/T45ezBkqzC1ogf+JwdpNZmVuenIywtJkCnDXX+clOPKnEMCGp9+CBgr4rZKkOSyP9hFP+sCtbE0G2BqsHpRPim13zjoUjza8cjniHmiIJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqaSOS8j6nuZ/WPJrNzkP04WKCQvjqAvOYGLTeMee8g=;
 b=CWVjut22wd1hUtRETdvYDWBLPOlgKDCC9JSMGNK8TZKTpqU9clhXbIVMDhb+WvjKdoWxfKEpWf3HmnbVa/FDNlNZkG+2BpLbGyvdHLPPTnjtJo1neoMmVdikbGkV0ev+l44WiElGuqlsG8wFGiilN3Txnndly7m6fk6wn16at80=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by SJ0PR21MB1338.namprd21.prod.outlook.com (2603:10b6:a03:3e6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.2; Sat, 11 Dec
 2021 03:10:43 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Sat, 11 Dec 2021
 03:10:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TAAAIttYAAAhJ/YA==
Date:   Sat, 11 Dec 2021 03:10:43 +0000
Message-ID: <BYAPR21MB1270B5DAD526C42C070ECB9EBF729@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
 <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
 <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
In-Reply-To: <b80bfe9a-bece-1f32-3d2a-fb4d94b1fa8c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9f77ba61-164d-42fd-8278-31c800a756b6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-11T03:04:07Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f79d5f9e-df62-4052-9745-08d9bc53d190
x-ms-traffictypediagnostic: SJ0PR21MB1338:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB1338672AD07C41DF3BBFA39FBF729@SJ0PR21MB1338.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P54fXBxLSd43U+7FkBmZrPKEkX8UMx6TXf9WnzFSPLLIB5gvPlyjZtQOlX4SJPqEqBB5kGy0L5oA1jYF39CvlIxWpEN2d1J0/YUUdPtutbRqwIm0oUOrUbbi5ZUcwVUEvr3i+6xx6yCUSGl2Ksrc0Mq+ZZBXMmF0lYrdBscUs9x0h0WLsfGrN+e3JeaeydWbOSUPaWQ5ozfvFDhJ5NCrlW3QncL/AdYGdeqvXDeQtpWnoSApxYeRCmlvMrXXTDk1cHqSYEUi/xgfdey+XFe6IDpPjw8+7T1srB2oanhDIflAGBuNFqKZlUpSwcmIILOBJafPjGQf7fygmPQkYRKnW8x8EwJfANVv97zDdEP0lmwRbXJylSHnf0mrNnaRHYUYP4hmAQae9hwpYcV6Zf35oM8LHu2xGSJi/DaCm+8zj0W4cV6e1mXxOI1c8ig88nvkTCPjROlEr6s5uEgv24Kdgvmzs+y6Dt1dubzfQ2nQDMujV81t2zc2orwYC2xEkorlaCmXq0JdlID6n6kj1nvXrFlTqM4+5FL5j4adMoXK75vjRo0IChFWCWpYsVT7kzYjwQ3qXrDKEWzDHEYyFHn3ShASrrKb81xNcJy+BeWFp/pcOjyloIcFQBtQwZY4YwDS9oAkFO2puuhrSgfr2noye8sEWNtFdOOrn9ZMGdjZnZZA3e6E/msz52cjxvczSGmjw3WcZp2Ii4PYvmw7vIQY/DibzbKFw7FMnEJV5/qH1YxggHQ7gh7zHDCcJyKqJpBsmDJj96p9zFs3PYXmK7aaVYYByaZxidbG00+8/EaEzAugnhJ39AUuf2u7ZW2pswFKkavcLiJZ9uQmaxkcH079G0FfR/bXV9AFggjXp1mOuN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(7696005)(316002)(83380400001)(66946007)(2906002)(8990500004)(5660300002)(38100700002)(76116006)(4326008)(82960400001)(55016003)(71200400001)(9686003)(966005)(508600001)(6506007)(66556008)(82950400001)(186003)(38070700005)(66446008)(86362001)(26005)(110136005)(54906003)(52536014)(66476007)(8676002)(8936002)(33656002)(122000001)(10290500003)(64756008)(491001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pYAH6n/ntf2rfSXvhyCJ+3ZKW1PDkEQC/AeUYevR8LW/Ha5n0+lcSUsueuFP?=
 =?us-ascii?Q?T2389mrN7hgvleP2ywNFfXgAh25ENYL1s3Kf0a+fXzP2kkwOo9lOiBqQprMP?=
 =?us-ascii?Q?5PeNA4lBsEE7LS9A9ZchGPu+w8gzfp9BgegPCYhot6N21Zt43Mw3r8jIgw8d?=
 =?us-ascii?Q?AgwBzB3fNCLWZG6gMZhV00zh1BbcjLQPBC9E58Lvmy2C4UvAIEDTMDyKDs9x?=
 =?us-ascii?Q?Z7GFUA4pTTlLPFBge8ynhmLZ9gqWfbF6kYHRIRSgzvGiPG0iaVId5dhZXfH1?=
 =?us-ascii?Q?0VQMvz+GrVQwr4zpSj/QUhh4tzF1e+17bFkOXDp8AU1sqxzV/bW4PVAWfaD8?=
 =?us-ascii?Q?qWGBcw3E4YNSGrnRSVDWflnT3eOACU1yMHld/dovRRzqSEpoyTKMMhKUEwoc?=
 =?us-ascii?Q?vplRM2EDnAcS/NA1v3OuDaqsmJdliokpPYiQ0KBU8Byk1cZJiHt6ECxlWgiO?=
 =?us-ascii?Q?ROfZLrkZRSvo+V9uc3IH2tFYxYjhIs/6nO0j5WESlvLjKBFhdx/zyaxoUIXC?=
 =?us-ascii?Q?vmyWT3f3ffBlqCkRIeQE8T2HgQxULRirdwHSnSRgBEUphW+3sOCHcvFhCOnw?=
 =?us-ascii?Q?hWnHUUTyN2JHcEINeJaDl3zlzxCYG/oWVMia8bLLYsUp7eAXAPhf1c3QedpZ?=
 =?us-ascii?Q?DFRuH0h1+KBbpiFedPHlFdEkqF4ncVlxjRKHOm5Y7N5DC5nPSTp7xF6x9tw0?=
 =?us-ascii?Q?lYi2YwMrUtFn7QbLPs112O63IChGutIdgMW7I5gK4WpqE1qyKVKbXLFulQuM?=
 =?us-ascii?Q?GJ54zB8gKWnZo2Q+5MsVU9bZ+OGqyP5sTMxuw7qPYAZlnFtZEilXTqmExioP?=
 =?us-ascii?Q?RGKk1xdHgFTPPMngUY1r2Ta/ktq8KeHckXRNbm9ZDxXAcLtsjsSh3LFp+gH/?=
 =?us-ascii?Q?sohp21dPuHuXZec6nrqSV5b+qGSaqkllBtFZXzXQaudSUOwLy02f+s69cBC6?=
 =?us-ascii?Q?YddLjRLdBIO0wyC9z+kper0wr3v4vNICR+mD1PdwclCJvG9NbBdxHC27UMPA?=
 =?us-ascii?Q?6z0NJIDcJ24jA6z6Rr2B08fZd19UgSQ138WNkKsm+8NZZenzB5wmdV4u1x8b?=
 =?us-ascii?Q?ZGbahNDZCxCHOTKZwQhzF/Q9uwIYZuem+QbdmZLEIyqfIuxiWwwwlh6Y6kLZ?=
 =?us-ascii?Q?0Qthic9ee1l+qs4NtD4Y/3s420QA1njcp9M9FQIqckvaAO3XBGEuraNHkn8Q?=
 =?us-ascii?Q?JafDSvEyduowNBoPilcFPrcs6/0qmyMorGOrNUimKOyjIcxiRN+03K/wSViL?=
 =?us-ascii?Q?2OOh6XRxbwC7SHc2boCO0whKZuFfyKPXw2W4U4Hfp3ycbcw1Uugj1V1Xwhc3?=
 =?us-ascii?Q?+k0H4ao91MSYFeXhXP8b6l8sNdXD2d1l6jAqqXXC9iTAedA3fMY4C7g+jnzo?=
 =?us-ascii?Q?8nE2oxqnapbS3jHkYI70+6qI9HMuQlkRhK2MWPPl/R5wByn+Y0fR54o+wCTc?=
 =?us-ascii?Q?lQcdhFll1gtQhnoXapADhtoM60nezjKdKkC/MpQOdaYckZQ91Vn+nGezRBX1?=
 =?us-ascii?Q?1c/o4wrgf6ohE/k6etFL2b5pcfeEIYm3zVdJHeMd82Pgi12Iv7vwVqFsq90Y?=
 =?us-ascii?Q?V8UkswphTinGM3sJD3BvJVYJ8QGIJ8lXCzsfnLaC2E0dR/mpRHPcQsn52Mwc?=
 =?us-ascii?Q?/sHRsV3jFBAIeTaNJibQ1JA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79d5f9e-df62-4052-9745-08d9bc53d190
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 03:10:43.1946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMutwNY3yy/2bc/5lDUX7BMk+CEJb1crIs6gWkmEji85Z3cZEROyh8jA6Hkmkk566Lby8sGmey6io/c0ogOXqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jens Axboe <axboe@kernel.dk>
> Sent: Friday, December 10, 2021 6:05 PM
> ...
> It's more likely the real fix is avoiding the repeated plug list scan,
> which I guess makes sense. That is this commit:
>=20
> commit d38a9c04c0d5637a828269dccb9703d42d40d42b
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Thu Oct 14 07:24:07 2021 -0600
>=20
>     block: only check previous entry for plug merge attempt
>=20
> If that's the case, try 5.15.x again and do:
>=20
> echo 2 > /sys/block/<dev>/queue/nomerges
>=20
> for each drive you are using in the IO test, and see if that gets
> rid of the excess CPU usage.
>=20
> --
> Jens Axboe

Thanks for the reply! Unluckily this does not work.

I tried the below command:

for i in `ls /sys/block/*/queue/nomerges`; do echo 2 > $i; done

and verified that the "nomerges" are changed to "2", but the
excess CPU usage can still reproduce easily.

(BTW, I got my 5.15.7 kernel from here:
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.15.7/)

root@localhost:~# uname -r
5.15.7-051507-generic
root@localhost:~# grep  . /sys/block/*/queue/nomerges
/sys/block/dm-0/queue/nomerges:2
/sys/block/dm-1/queue/nomerges:2
/sys/block/dm-2/queue/nomerges:2
/sys/block/dm-3/queue/nomerges:2
/sys/block/loop0/queue/nomerges:2
/sys/block/loop1/queue/nomerges:2
/sys/block/loop2/queue/nomerges:2
/sys/block/loop3/queue/nomerges:2
/sys/block/loop4/queue/nomerges:2
/sys/block/loop5/queue/nomerges:2
/sys/block/loop6/queue/nomerges:2
/sys/block/loop7/queue/nomerges:2
/sys/block/sda/queue/nomerges:2
/sys/block/sdaa/queue/nomerges:2
/sys/block/sdab/queue/nomerges:2
/sys/block/sdac/queue/nomerges:2
/sys/block/sdad/queue/nomerges:2
/sys/block/sdae/queue/nomerges:2
/sys/block/sdaf/queue/nomerges:2
/sys/block/sdag/queue/nomerges:2
/sys/block/sdah/queue/nomerges:2
/sys/block/sdai/queue/nomerges:2
/sys/block/sdaj/queue/nomerges:2
/sys/block/sdak/queue/nomerges:2
/sys/block/sdal/queue/nomerges:2
/sys/block/sdam/queue/nomerges:2
/sys/block/sdan/queue/nomerges:2
/sys/block/sdao/queue/nomerges:2
/sys/block/sdap/queue/nomerges:2
/sys/block/sdaq/queue/nomerges:2
/sys/block/sdar/queue/nomerges:2
/sys/block/sdas/queue/nomerges:2
/sys/block/sdat/queue/nomerges:2
/sys/block/sdau/queue/nomerges:2
/sys/block/sdav/queue/nomerges:2
/sys/block/sdaw/queue/nomerges:2
/sys/block/sdax/queue/nomerges:2
/sys/block/sday/queue/nomerges:2
/sys/block/sdaz/queue/nomerges:2
/sys/block/sdb/queue/nomerges:2
/sys/block/sdba/queue/nomerges:2
/sys/block/sdbb/queue/nomerges:2
/sys/block/sdbc/queue/nomerges:2
/sys/block/sdbd/queue/nomerges:2
/sys/block/sdbe/queue/nomerges:2
/sys/block/sdbf/queue/nomerges:2
/sys/block/sdbg/queue/nomerges:2
/sys/block/sdbh/queue/nomerges:2
/sys/block/sdbi/queue/nomerges:2
/sys/block/sdbj/queue/nomerges:2
/sys/block/sdbk/queue/nomerges:2
/sys/block/sdbl/queue/nomerges:2
/sys/block/sdbm/queue/nomerges:2
/sys/block/sdbn/queue/nomerges:2
/sys/block/sdbo/queue/nomerges:2
/sys/block/sdbp/queue/nomerges:2
/sys/block/sdbq/queue/nomerges:2
/sys/block/sdbr/queue/nomerges:2
/sys/block/sdbs/queue/nomerges:2
/sys/block/sdbt/queue/nomerges:2
/sys/block/sdbu/queue/nomerges:2
/sys/block/sdbv/queue/nomerges:2
/sys/block/sdbw/queue/nomerges:2
/sys/block/sdc/queue/nomerges:2
/sys/block/sdd/queue/nomerges:2
/sys/block/sde/queue/nomerges:2
/sys/block/sdf/queue/nomerges:2
/sys/block/sdg/queue/nomerges:2
/sys/block/sdh/queue/nomerges:2
/sys/block/sdi/queue/nomerges:2
/sys/block/sdj/queue/nomerges:2
/sys/block/sdk/queue/nomerges:2
/sys/block/sdl/queue/nomerges:2
/sys/block/sdm/queue/nomerges:2
/sys/block/sdn/queue/nomerges:2
/sys/block/sdo/queue/nomerges:2
/sys/block/sdp/queue/nomerges:2
/sys/block/sdq/queue/nomerges:2
/sys/block/sdr/queue/nomerges:2
/sys/block/sds/queue/nomerges:2
/sys/block/sdt/queue/nomerges:2
/sys/block/sdu/queue/nomerges:2
/sys/block/sdv/queue/nomerges:2
/sys/block/sdw/queue/nomerges:2
/sys/block/sdx/queue/nomerges:2
/sys/block/sdy/queue/nomerges:2
/sys/block/sdz/queue/nomerges:2
