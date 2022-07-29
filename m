Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD195585384
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 18:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbiG2Qgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 12:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbiG2Qgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 12:36:38 -0400
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [216.71.153.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1999823B7;
        Fri, 29 Jul 2022 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1659112597; x=1690648597;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rj4DLUZzOBWl0i+H6ZkSAlszY10JN1/oHojFXuAaolM=;
  b=HgSi5+fbAw06z4ih5RAUPDN3tJgVQcocqZ7UnF9mvSmFiyzHSHQB1ZFH
   RDYHz85AVZP546UK9FHKeVQrgbr7kpZbTesoEXxodAAJEvgxkUe/sWGe8
   4xj1OfbuV8laM23myLHCUjlWRO071D9jlalrRVqP2QrwGibYsOgwHLhNv
   I=;
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 09:36:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QVvjoAsDXmeen5qc7P5cR0iMMXt20wENcrtu5NLsA2/1gWccxt3j57nw0tl+zkOQxK+u3ycOMw5unhgm5CVDvTVSqeNSQfvqoAZfGBbI+TkB8WhdN39dyf92bN+p2dYT5DNe1K0mDlXGdZsgcuhBfts+hWQ5XBiN2dIB3YaflYrU1g9btVQaeWT2Tcv/YLOjI10fHBWb6qGJ69akFS0rS03WEBDitfzhbca8y3gYD+B13SNFH4pHA8wl3sBK8TsQs1HI5y3/PChkR2Cvn0YP59vin/AraYmydmCm2bkU9pwPVe1mO9lcAfi75t43E687/dWUpFWVJvn/1KgNHTYEQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NN0c2KkoAgFzfN9JcV8U95Rp9SoIMY//PJJyQjsdriA=;
 b=ncITXdLt0WCFmtsWdbMukqyF9dZ+zXVsSc3lkQ8met5SINKXQEPUFT4WsSoQE4s3gHCeX9WEQ9wCLvcvGWkxm02sUbX3rjcHcf9ViWScm2/eUkeZHarHy+V8XRlWG3tAKFOqe7n++xWzMzOMEu5/8Yk0LRUIVulgaCrtkOd+YH/coZDUdE+ZQrqkxhgp/Yn0y57aiSKo/dNzB+AZvAWvZhqxTiZnVR4w5RP+XKfMq05y5Rp7LldR0Z9ms8lqnRif3trGMzJ34DaZqv0sTWGyVM/h6clIyZdkON5k8kXsPGfviSsszSWt0XSQZk5bPFyFUI+HUns29spRe07Qb/uFag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NN0c2KkoAgFzfN9JcV8U95Rp9SoIMY//PJJyQjsdriA=;
 b=Tqnrf/KxiCLSazTCHt1ydGisH8+QlB35jberpAz8qUdPuyXGR4BPGgifF4iYuogMdEgZX4ewW6EuxhBNek/eLNxArc+UPT3YCrhE4sQxReITplr9n3sYkhyRoaBE/mD9g+OuPpDGGV0fstJfuq4Fjmd6FO8vJYjvILC0n04GMms=
Received: from DM4PR20MB5061.namprd20.prod.outlook.com (2603:10b6:8:88::22) by
 DM5PR20MB1562.namprd20.prod.outlook.com (2603:10b6:3:13b::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.12; Fri, 29 Jul 2022 16:36:33 +0000
Received: from DM4PR20MB5061.namprd20.prod.outlook.com
 ([fe80::7165:446e:8314:33e2]) by DM4PR20MB5061.namprd20.prod.outlook.com
 ([fe80::7165:446e:8314:33e2%6]) with mapi id 15.20.5458.024; Fri, 29 Jul 2022
 16:36:33 +0000
From:   Arie van der Hoeven <arie.vanderhoeven@seagate.com>
To:     Rory Chen <rory.c.chen@seagate.com>,
        Paolo Valente <paolo.valente@linaro.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Tyler Erickson <tyler.erickson@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgAI9feCACXh9iYAA5pIEgAGob5M=
Date:   Fri, 29 Jul 2022 16:36:33 +0000
Message-ID: <DM4PR20MB5061EF9EC0FD7606C6E27DD3F1999@DM4PR20MB5061.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44097AAA14A819BB2C7B4AB3A0909@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DM4PR20MB50613F96089AC468679FB415F1969@DM4PR20MB5061.namprd20.prod.outlook.com>
 <DM4PR20MB5061638AB3F389ECD0714029F1969@DM4PR20MB5061.namprd20.prod.outlook.com>
In-Reply-To: <DM4PR20MB5061638AB3F389ECD0714029F1969@DM4PR20MB5061.namprd20.prod.outlook.com>
Accept-Language: en-US, en-001
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-07-29T16:36:31.714Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
suggested_attachment_session_id: 3e6fde08-85d2-018a-a881-26e82f5155e8
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6bb3bee2-7e39-4383-08c0-08da71807f7d
x-ms-traffictypediagnostic: DM5PR20MB1562:EE_
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u5KH0bngu5HGhOXmNUrIol9UKnlc86Ig1dcCwXFN5dNeV0Oc9aZaGmEHZNQcgTme3KhWV4aSra9CnilV6y/WWhteG3q/D2c/xeX4ylRrwzYv3dGF4DEk6kyVJ7uXrNj7PNUF+xiTAJTm9hWqLTmsW57zqfqA2QFFXHgz7D2rbGplmZgnVYJbo4k0RuWTbfIs6rTc4mf7BhHW9C+TLPR4+RNVtMfntDVmgAeKWS/XmaWpqFaUQs5AB/H9W7VkpwQMJFiVzKGhB6Hmirvo4FsSpIyliGr9nJrCOzndDxZ2K02AGBMw+MzR5ebax03ma3C7mpst+WE1g6KrFYcCE3s9WiFq4gBj8ZiSs11vbEN1kUq+lYYwOuNnELwJ92q09dCzNWEZHhqxGIXXwlKqdODgySHhsZfmnFiB/LijHD8Fovp/t1hqaqnAm27T7VzxWOM/90FP0toai4IhsUnZUBTr6j2+aHMv+EPLZGzFaXapXFv/YOAju0UEEwADnqWzQDWKvtN/YMyfz5Ir1ZoT2tT5pRhyfdJp31kNopb01JbUY2gsr96YnD0zgnZJryclq7r2hJhPT71r3vjuHQ6Y+/vU8SD5UGJzd6wqCumKdNWrhSNxQbRq6Jxbtoojz0B4twSU/TNXibgv6oYIEVuet6fOlJoForxh5E2ODWty2csoh9I3Z4bMRWq23OheWRJ1ZF/DoJ0xxS7dACVQYXNeR3/MdebLShdKGyIn3HkD+fXnyOuXa9wAj9ChXuWRDp1vXwWuU4xkMaQngspZGHwiOrdk/Bs+8UOMK0TRabx1x5WXTGbh2u/N8yY5gbgKPFUIjeghs6JlgvSEI38toP9Diktjgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR20MB5061.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(136003)(376002)(39860400002)(396003)(9686003)(26005)(2906002)(7696005)(83380400001)(41300700001)(53546011)(86362001)(6506007)(478600001)(55016003)(316002)(8676002)(38070700005)(52536014)(54906003)(71200400001)(122000001)(38100700002)(5660300002)(186003)(76116006)(66946007)(110136005)(966005)(107886003)(4326008)(91956017)(33656002)(66556008)(66476007)(8936002)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?0Yp+84uPYDkq5hG6RbjptQadk03JS8QOBqXadBK+oiAGCFONXVfYs5/e?=
 =?Windows-1252?Q?XQEfSpsfvBz4bKQXXoLHXzLNIwYt/P7lmM1dLeEUxjZMP0KJP2CRIaF1?=
 =?Windows-1252?Q?B0LzOZh5+LgJaHsyMJbSfswFvTukT/UzEOPXf6pqhqHObcr7CUSQoJkM?=
 =?Windows-1252?Q?yUcCXi25/WLU++1kZKhiGKWHc8bxlBgeAyKRCT1dtakvE5MN7xRV+YfN?=
 =?Windows-1252?Q?49+2VnBczI/IB/F1wTVZ8Z5fa3K32m+aclOr6NKe8LaXxoz5KrL102xF?=
 =?Windows-1252?Q?ahfIsdycv8XEck5ZeFo88EgyvIuiS8gr5tKT4oEDBQJu0eWHCW1lDgB0?=
 =?Windows-1252?Q?Sh22EYAFulbtcVK0G1Wl9wdneiO6WXxRu9E9PsmJiHPrCEWjQJ41HZUy?=
 =?Windows-1252?Q?nKAdip0DEibgVVTC5UKszZPI4RMp7a5XirT27agP+LtzE1dJBAQp7cYz?=
 =?Windows-1252?Q?TKAIzgwfcn8KEC3bn9xfvN6o1GfiKKZ45qRMiY8rOogzdHOCQT0lcPtr?=
 =?Windows-1252?Q?iKGqlyX+IQkdZrzW3DWB4cHZiOIX/49U0VzEKn/H/KPpwxgs9XjPQPH6?=
 =?Windows-1252?Q?f+8JtFRKRVbjp8y1pt77pRsAKpEoc4qWMns7isVOZV6OPr+34+BOdIYt?=
 =?Windows-1252?Q?Cfyisx/YTgOIoUZkya0X9eUE4LdSHXqWCCJA23g70zwuiSlOxi9oVs3u?=
 =?Windows-1252?Q?wqW4DKaLnC8BM3KhpzZh/EEB8msFa5CUYWnVDzsowHSPkZ4TX6U8u/wO?=
 =?Windows-1252?Q?Zb+E20yMWD8rmZdt929IzBFgae48wCap02WqjlpVmm/Oo6/sGHISJeGw?=
 =?Windows-1252?Q?uwzK4U/9Khw9CM4BDIXieIZWwkiryRzeID2oQzlWO9yxw6f8sR62y9lL?=
 =?Windows-1252?Q?y08YAHdo5ZLl25QW1QO6TCpmO14CYY+r0npM09HvMMqzP5Vud79/JKQN?=
 =?Windows-1252?Q?5gutjludnqqEZaAwU4TitoI4UOwveaf/b9Ixk2ME8/PlqEAxy9/oxmxz?=
 =?Windows-1252?Q?ySJoQny2ewwU2LHUJDpdosF/1g8LuiG0uvp8icbRFM8F0BmHJVZaA0oG?=
 =?Windows-1252?Q?pPquQfrqCzHbq/vP2/DO5Fip2gLy1LnftGJrH9HDgb92Y+/5d/0L2XHY?=
 =?Windows-1252?Q?vf8/aNzB7sIT4dpQoaRE1ouxQwOwc/wCgWRcIppHun2PnVhpr9a01Ixp?=
 =?Windows-1252?Q?RxpyFkEABpOtxw+XSwTKeAkyYK4Fo5iluMRoJseqsncCfGWpycv4Kp2W?=
 =?Windows-1252?Q?RLgoA0Q8z84104jCkvO4/owRTllSxSA2lzVUfay8HQpBQY0TRslGEk4A?=
 =?Windows-1252?Q?dyQc9IbGTtW3LhTN7r6iQQbkTRrUIJGL6uK7cZ8BYoW9jCW7vqTxfXAp?=
 =?Windows-1252?Q?UO3mvp8m9k2at5VmnzoZ8dAqCGPgcvhi7B0MP2q6w4SPbwjKD2mrJnnJ?=
 =?Windows-1252?Q?2tyojze1td6+X9vKKc+VwYNF6B+mVvTG+5fnS9UOnCSehQve/30Hzk+r?=
 =?Windows-1252?Q?CGauPpHWzzQFYcgVN3dADnbOrcj6BK6ufQ1xLwWmHKaSlvLyc+oNigXN?=
 =?Windows-1252?Q?ryilyUEnHKmopvT7QfFlau9lVXJvFL2Q0K4SZEUKC67o++AGCxkUxJeR?=
 =?Windows-1252?Q?0Q3XeppqNH1ONCuFaVa3Rl4qy95Vq02sLskbq5AccVgG51HWwIDlHfbT?=
 =?Windows-1252?Q?p0Ln20WWVL63gJA/yQEN8E9xnVD63DezmsaOs6ksp+6FhB76eyeXGw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR20MB5061.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3bee2-7e39-4383-08c0-08da71807f7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 16:36:33.4531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZR/MF1+jiezT3t+U9m40bPaOD4fBtfKCQJGOnzQNWcrURyaF97VlIQMP+SuFpzvjHRnfQrf7TLk43A73D5d9LivPdNayRpRZ3G5Rihg75nM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR20MB1562
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<Resending as plain text>

Adding Tyler Erickson who worked on the patch for concurrent positioning ra=
nges that may be related.  Adding others at Seagate who worked on validatin=
g the patch as well.  (Muhammad, Michael, Andrew, Varun)

Thanks,
--Arie

From: Rory Chen <rory.c.chen@seagate.com>
Sent: Thursday, July 21, 2022 5:59 PM
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; jack@suse.cz <jack@suse.cz=
>; andrea.righi@canonical.com <andrea.righi@canonical.com>; glen.valante@li=
naro.org <glen.valante@linaro.org>; Arie van der Hoeven <arie.vanderhoeven@=
seagate.com>; axboe@kernel.dk <axboe@kernel.dk>
Subject: RE: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives

Hi Paolo,

I=92m from Seagate China and face a problem when I=92m evaluating the bfq p=
atches. Could you please check ? Thanks

Issue statement
When running performance test on bfq patch, I observed warning message =93b=
fq_actuator_index: bio sector out of ranges: end=3D35156656128=94 and OS hu=
ng suddenly after some hours.
The warning message is reported from function bfq_actuator_index which dete=
rmines IO request is in which index of actuators.  The bio_end_sector is 35=
156656128 but the max LBA for the drive is 35156656127 so it=92s beyond the=
 LBA range.  I captured the block trace and didn=92t found request LBA 3515=
6656128 instead only found max request LBA 35156656127.
I=92m not sure if this warning message is related to later OS hung.  /var/l=
og/messages file is attached.


Problem environment
Kernel base is 5.18.9
Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
Actuator LBA mapping by reading VPD B9
Concurrent positioning ranges VPD page (SBC):
LBA range number: 0
number of storage elements: 1
starting LBA: 0x0
number of LBAs: 0x417c00000 [17578328064]
LBA range number: 1
number of storage elements: 1
starting LBA: 0x417c00000
number of LBAs: 0x417c00000 [17578328064]



Seagate Internal
From: Arie van der Hoeven <arie.vanderhoeven@seagate.com>
Sent: Wednesday, July 20, 2022 10:41 PM
To: Rory Chen <rory.c.chen@seagate.com>
Subject: Fw: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives



From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, June 23, 2022 8:53 AM
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel=
@vger.kernel.org <linux-kernel@vger.kernel.org>; jack@suse.cz <jack@suse.cz=
>; andrea.righi@canonical.com <andrea.righi@canonical.com>; glen.valante@li=
naro.org <glen.valante@linaro.org>; Arie van der Hoeven <arie.vanderhoeven@=
seagate.com>; Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator drive=
s


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


Hi,
this patch series extends BFQ so as to optimize I/O dispatch to
multi-actuator drives. In particular, this extension addresses the
following issue. Multi-actuator drives appear as a single device to
the I/O subsystem [1].  Yet they address commands to different
actuators internally, as a function of Logical Block Addressing
(LBAs). A given sector is reachable by only one of the actuators. For
example, Seagate=92s Serial Advanced Technology Attachment (SATA)
version contains two actuators and maps the lower half of the SATA LBA
space to the lower actuator and the upper half to the upper actuator.

Evidently, to fully utilize actuators, no actuator must be left idle
or underutilized while there is pending I/O for it. To reach this
goal, the block layer must somehow control the load of each actuator
individually. This series enriches BFQ with such a per-actuator
control, as a first step. Then it also adds a simple mechanism for
guaranteeing that actuators with pending I/O are never left idle.

See [1] for a more detailed overview of the problem and of the
solutions implemented in this patch series. There you will also find
some preliminary performance results.

Thanks,
Paolo

[1] https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYePr=
A0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LRiTVoIO=
UC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLONHEoI3p3e9Q=
NIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYBFn5S2WjBDQq2kzDz=
ZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEVa1b6bQByX6grF5pn3pTIo=
0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIKDrNTALs3xQvg03DH4jLez-T2M9=
xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F%2Fwww.linaro.org%2Fblog%2Fbudg=
et-fair-queueing-bfq-linux-io-scheduler-optimizations-for-multi-actuator-sa=
ta-hard-drives%2F

Davide Zini (3):
  block, bfq: split also async bfq_queues on a per-actuator basis
  block, bfq: inject I/O to underutilized actuators
  block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
  block, bfq: retrieve independent access ranges from request queue

Paolo Valente (4):
  block, bfq: split sync bfq_queues on a per-actuator basis
  block, bfq: forbid stable merging of queues associated with different
    actuators
  block, bfq: turn scalar fields into arrays in bfq_io_cq
  block, bfq: turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS

 block/bfq-cgroup.c  |  97 +++++----
 block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
 block/bfq-iosched.h | 149 ++++++++++----
 block/bfq-wf2q.c    |   2 +-
 4 files changed, 493 insertions(+), 243 deletions(-)

--
2.20.1

Seagate Internal

Seagate Internal
