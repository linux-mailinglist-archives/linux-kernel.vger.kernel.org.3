Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482B15B1BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiIHLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiIHLiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:38:00 -0400
X-Greylist: delayed 122 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 08 Sep 2022 04:37:58 PDT
Received: from esa.hc4959-67.iphmx.com (esa.hc4959-67.iphmx.com [139.138.35.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00193113C72
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=seagate.com; i=@seagate.com; q=dns/txt; s=stxiport;
  t=1662637078; x=1694173078;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QxvZ6eorJIcO+WkyPSzI3TeOdkMTRt408B8uVJ1lpXg=;
  b=Lr8L6ovWCP2Muqsie366ykc76lTPvVS/u3G/cS7vmLdWWyEyjbiYN9nr
   RPtE9L5KYultSIUfwH8vtgQTx/hp+AXAl1TtHYytRYtGScv6WOZUfM63I
   wIKYyPBLEJ+sGz+B7EmsFeuUtwIqJBbV83Idk43dB+tqe2oa96GKQlQE6
   E=;
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hc4959-67.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 04:34:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvGIjSbrgSW3aXqBUi79h/E8TtNQnpr49x8nCSTqAWTwnvQPP7z/NR4W1FHcRQ4Cyo5/ktjaV0Q5hpOaUPjBBS84xOPWd9ODQFDT1O/VXmsKekrwaQZw1ezBpK2FbKtJVd5nTju/nCyHk/iOb1cawF+KyMXprl45Hf56triDEZVK02O3EyVjfrU8J9noCo7aIa1H7xiTYEufl8vSO6pJT69dXoufZILYe/zpZ8scxaQPhERa/7rXBMHAk6QI90ZM7xRZcdX4BzMH16WL/GS1TNgcgJKB1I8ZQsvAYaIjfv4J3zOVgAdcaoJnFHF/db+ItHenU3EUa5ruLVEhGNJTJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqKoOwdOSTj9nEH/Qljbv5Vm8Eg08P20oBz02EDjaYQ=;
 b=EuHZf4rU0fNsQ1pBBvx3ptp6RlKc149EgAQvHpgJOjTQB+I1nssEmH14n/Vqtwz4m/pZOk9x9OPhe9nsx0wiN2+znnlnK/f5aKsGxe3tbJduNWQmCHPpB1qcctVB0fExLALZYvOwmcsbeiRJAd+rIM6Ava7JWqLjonBHKA7FVVykZymGJc53LZZhQC1tmYV3fjkyCnlzL70pHHAr7lgcQE66tMdNIRutp9a36lBqL2VM04yjFnX1i5s/DCNLfbhB/QpndF7H3FiUNDcCQ5tyMPe+JXPU/gJOdD9FU3CtPSKJ9MvInLwziATxXMw19wQ1aFcYCrDV6j7ddgScsnxzzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seagate.com; dmarc=pass action=none header.from=seagate.com;
 dkim=pass header.d=seagate.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seagate.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqKoOwdOSTj9nEH/Qljbv5Vm8Eg08P20oBz02EDjaYQ=;
 b=F7AHP4WhIbiA2teDi6f1LIICxHxNbp+tPjFOI94NAvU1gKdg2LRJa7/ufCreoqUMe/rqZfZQS6OGHi4k8kL9wpETIRpedf21Czr0bC4RZLL2APIWPatSFg5eVSmaxIreJm+WHsECV9hm9XbPeyVdzLVR9klR4hEEqV8Q7YXEC80=
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com (2603:10b6:a03:42c::20)
 by MWHPR2001MB1888.namprd20.prod.outlook.com (2603:10b6:301:21::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Thu, 8 Sep
 2022 11:34:46 +0000
Received: from SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::35cd:ad03:c16b:589]) by SJ0PR20MB4409.namprd20.prod.outlook.com
 ([fe80::35cd:ad03:c16b:589%6]) with mapi id 15.20.5612.012; Thu, 8 Sep 2022
 11:34:46 +0000
From:   Rory Chen <rory.c.chen@seagate.com>
To:     Paolo Valente <paolo.valente@linaro.org>
CC:     Tyler Erickson <tyler.erickson@seagate.com>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Muhammad Ahmad <muhammad.ahmad@seagate.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "andrea.righi@canonical.com" <andrea.righi@canonical.com>,
        "glen.valante@linaro.org" <glen.valante@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Michael English <michael.english@seagate.com>,
        Andrew Ring <andrew.ring@seagate.com>,
        Varun Boddu <varunreddy.boddu@seagate.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Topic: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Thread-Index: AQHYhxl16wZu53I2nkyhDu//lRykYq2Hfy1sgB6yWuSAAgaVgIAAJ4jqgAzCDACACvKxAIAVNerrgACKJICAAAiMhQ==
Date:   Thu, 8 Sep 2022 11:34:46 +0000
Message-ID: <SJ0PR20MB4409997FB0529DF0B2FA153CA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
References: <20220623155335.6147-1-paolo.valente@linaro.org>
 <PH7PR20MB505849512979A89E8A66FB24F18E9@PH7PR20MB5058.namprd20.prod.outlook.com>
 <SJ0PR20MB44093D6FB740E543EDAAC002A0629@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <74F8D5E8-0D56-413B-A3CA-7462D9C862D6@linaro.org>
 <SJ0PR20MB4409EA5AC40DE61ED7A4BB13A0659@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <DS7PR20MB4782D8436B69B7EF53749425896D9@DS7PR20MB4782.namprd20.prod.outlook.com>
 <21A4C080-7FFB-4ABF-86C6-E8E05BD83E6C@linaro.org>
 <SJ0PR20MB44098A7A5D1904FD68DFE73BA0409@SJ0PR20MB4409.namprd20.prod.outlook.com>
 <D21B6E4C-F190-4B53-88A7-4650020DB6A5@linaro.org>
In-Reply-To: <D21B6E4C-F190-4B53-88A7-4650020DB6A5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Enabled=True;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SiteId=d466216a-c643-434a-9c2e-057448c17cbe;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_SetDate=2022-09-08T11:34:45.646Z;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Name=Seagate
 Internal;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_ContentBits=0;MSIP_Label_56e366eb-86f1-4645-85a7-f29555b26fee_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seagate.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR20MB4409:EE_|MWHPR2001MB1888:EE_
x-ms-office365-filtering-correlation-id: 2fce610f-3605-4699-96a5-08da918e21ec
stx-hosted-ironport-oubound: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GHH8zGg5Rui/vGmIh4c/3e36Qzk7m9LSvpqW9g8lGojh029cHmib4bJRogsVeT08iotyGb8AZVB7usc+kabpsJyKR5mh0Uu6/z/9c7QITBsl9j02lfbE6WfSoetvJL4JOJgFAP/3Fg420Joyk3AmzNuUF4ekZxrnEMHwtqJCGztVlUKSdKAq7+C810iHCA+dNlPm3as7bKHwIfemrFqP2usrcUTq0v3X8sapmezFRgmcvAd1D2GZG9LygqDXcntNJaiKNdlZZXf1smo8SdZbzemKp8J+OZ+tzKrdV7AIuwR9mn4Qwn7wlxtMcVvTXR3YhqLTLGpzKSsDebepaxkz428IpzEOvmnCpiqqYZMtrYLlOkRgyR+E+lWr+dZUexeqStM9KYrqCSIKNWDkSx0NVfrMZ25w+CGlP0E1O/SNmUXwa9a09zr69x3ML2DY8mBh8v5R9NCA+QytCkLIq6pD/EJxuYNqyOjffyY2frfwu08BGEW0u0w1Cns/qtsvtX9029HL/Uvsmo19esshU0zkWFa/+StkLlOqpzCqtvegOwMa8jVFXYoyG2Mac7KOLgz+xp5uE3v9gSLYORJNNrVHSaNlRfcjRh2uYaeKJZzL0zKaNzTOHiVFrw4cQfv5fXvQ5uTi0veAo7kmKKgfKadXarrYo6VHNj4ra4n7cIQo5SKw75QQFPO7+yt/Y5sJOo81Yjx6fOexS4Gqkj0xksW5J11KQjreNYwciYoWSlYtADieKHQQYdMzE+LG8Fi7li+w+p5Dv8j/UZMlH3iBJ8jnyPNVKmGinDEykmle59OHVXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR20MB4409.namprd20.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(376002)(396003)(346002)(366004)(54906003)(91956017)(316002)(86362001)(6916009)(186003)(966005)(71200400001)(6506007)(7696005)(53546011)(41300700001)(478600001)(38070700005)(26005)(9686003)(2906002)(30864003)(33656002)(122000001)(66556008)(66946007)(83380400001)(55016003)(4326008)(8676002)(8936002)(76116006)(66476007)(52536014)(64756008)(66446008)(5660300002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aJcSV/7giGZ0rBB4B6KT95fGSHRNquseDWBoLjf9dQyOq1VbRNMIED3Wm5?=
 =?iso-8859-1?Q?8HLe/26Q9lBW0acHizcjVQ76CmLwaUHCfejvg9dHEgj51M/VTB1hAao0KR?=
 =?iso-8859-1?Q?IJno/K4A/ipHGTu6pn2N3GiuDtUson9L+/76V4GQnRoOIMj+mSpqh/r3VM?=
 =?iso-8859-1?Q?7DhP4ijARG0BfzY8IcX9neXHIdGRMcL5pRbZUpOUpXopxskUkO6v11YBcF?=
 =?iso-8859-1?Q?iu5Gd4vKJlLMZdVoAAsBDgfqdvpvXqoabTNVleM4bAUzmpPUTqt8lwof/1?=
 =?iso-8859-1?Q?f1UVOt+MCBQzNQElc+sh/cSekK9/ihau8mFXpvufIN1joMdD7jZu05I4uP?=
 =?iso-8859-1?Q?mJ+TGLk1tmaYLRGxY/MhPRdj61QIDLd6xFAYLjhw+9fsaMGZ91zlGgygX0?=
 =?iso-8859-1?Q?mHnRHBOzxaEzQE6Y+6T+ZGQMm5QUKR8vZBYvCczlI+CQmigmKJqliNeNi1?=
 =?iso-8859-1?Q?DPZk1M/gqyoLDN/zXvcStCb/okE73DU0SBCH8Hl7wYvTsx18OqTwNvR805?=
 =?iso-8859-1?Q?VjmQV873/lhkmu4plU6rrhWPHmnunWHbVYFeTu48t6S/cZ2t4SFJPbwlJs?=
 =?iso-8859-1?Q?VUcK9O0cmVsHHxbG8DDm9FcAsk0/s3MFqZ/TkIn5HlTfSCBElLyiLDLavI?=
 =?iso-8859-1?Q?1dzPGbWxI5YukGKmp/+fJ0d8TmEbRr9ckGPtO2hO+tDw2ID2p7U9wCROK3?=
 =?iso-8859-1?Q?/pSx9p7/opplLO+HneGIC+A8zoZjT6L96SNHjU/c2MgjUt2pGaN98IVQtc?=
 =?iso-8859-1?Q?2adveBaMplQwmTnJRbKCEkW+BUG38qsBXTOhtnejHPAupHVscekTaZurFs?=
 =?iso-8859-1?Q?OWlklnRPkiHzHMyBlxe1N13jAlf5VZhnhYrJMAxDT5FtZeT6zmrV8ROFMM?=
 =?iso-8859-1?Q?x5G6tTpq6goOaD3ZnZWUTkaZY25pFE0SQM4YplUzSRORIxO63RSpk/ZOB1?=
 =?iso-8859-1?Q?vvvA9lzeSbG96TI2s6hqOs69SAoX4ACtOZnu3CRTqWb/TMg/DRg6osDWnr?=
 =?iso-8859-1?Q?4j9/0TsdpMDD3Rjfu8idaV+brB38a1oQiuGmzQgGam691Q8Hk/KGNEtECI?=
 =?iso-8859-1?Q?UKPvDE+2vROWwEHZnvRDAFRgsymKuGtWzqwJ4Y58cjb1vhrSi9UvL+ihLB?=
 =?iso-8859-1?Q?oGqREzjx5/1fspf+LQsyoipu+XD+aV3n0mBrHlrrP9gUtdlzegSe3Wzw1H?=
 =?iso-8859-1?Q?/22A28Krm2aD+ZIJc2ij+muGzPjLZKTryF4fSlF7wyX71L3TXur7X+H6QD?=
 =?iso-8859-1?Q?pUO5lbb912CBHw43dgzddbO8Fau+HWtxaKGlLN2QAKhjOmDPFW+kcw0rVK?=
 =?iso-8859-1?Q?S5GO89Ncpwd4JMCaEl/uGk9J/B/HNpFdEwNOcfdtiwYfLmKf5EMfkqInFs?=
 =?iso-8859-1?Q?ZNYuvwYG0Ck/E8ifEi1r6v+gXKDgOOMzohyZAO5Is1VwHVvR2c7kFbsQrY?=
 =?iso-8859-1?Q?AXWo/WNv7E4Lii+fNwL4TsvC4dpEm+GgTCE0BZIWkiIlYXCtMtU1kV2FpH?=
 =?iso-8859-1?Q?GUfuB5VfRTB82haNC8kyFBCrMtcB1j6/T/uiqZ1oupkhxrnJ1k4BWxz1xl?=
 =?iso-8859-1?Q?7KWnUI5T5qglR0Jx+0hX4vPOL7R4QEaySio06r6wNmGCorkehf2Pd+ax1e?=
 =?iso-8859-1?Q?prbdpiSINtVfubArJz5plrpWfWyzoRuvjl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: seagate.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR20MB4409.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fce610f-3605-4699-96a5-08da918e21ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 11:34:46.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d466216a-c643-434a-9c2e-057448c17cbe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoZEQQbSVY3cgO6UGZVRlSVXFrHZ9XMGb/6AXrlyohIHNDvephRhVfGBA1kdrcur24/xkzk6kymB+/IaLP9cwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2001MB1888
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I attach wrong code change. Here's the right change made by me.

<               if (end >=3D iar->sector + 1 && end < iar->sector + iar->nr=
_sectors + 1)  //Changed code
>               if (end >=3D iar->sector && end < iar->sector + iar->nr_sec=
tors) // Original code

Unfortunately, the crash is still existing and I can't find any clue from /=
var/log/messages



From: Paolo Valente <paolo.valente@linaro.org>
Sent: Thursday, September 8, 2022 6:54 PM
To: Rory Chen <rory.c.chen@seagate.com>
Cc: Tyler Erickson <tyler.erickson@seagate.com>; Arie van der Hoeven <arie.=
vanderhoeven@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; lin=
ux-block@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.k=
ernel.org <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.r=
ighi@canonical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <g=
len.valante@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English=
 <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varu=
n Boddu <varunreddy.boddu@seagate.com>; Damien Le Moal <damien.lemoal@wdc.c=
om>
Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator d=
rives


This message has originated from an External Source. Please use proper judg=
ment and caution when opening attachments, clicking links, or responding to=
 this email.


> Il giorno 8 set 2022, alle ore 04:46, Rory Chen <rory.c.chen@seagate.com>=
 ha scritto:
>
> I change the comparison condition and it can eliminate the warning.

Yep. The crash you reported also goes away?

> <               if (end >=3D iar->sector + 1 && end < iar->sector + iar->=
nr_sectors + 1)
>>              if (end >=3D iar->sector && end < iar->sector + iar->nr_sec=
tors)
>
> I don't know if this change is appropriate

Unfortunately your change conflicts with the standard code, taken from
the original patches on access ranges [1].  I've CCed Damien, the
author of this patch series.

[1] https://secure-web.cisco.com/12uvPqOwOjHJPiVGM6hJ7791jpWxxy8My3bFD1oA0p=
Nh9m0W778f8IM7HPxjRUL8-94N0gKahHwtK-sEv1Tgk2Oo4H9GTAlLoml_uWF6BGktvDAlDp-zd=
NQUzCL7y1OCz_MJMaNlS5h0iwsE3q9m7tJsCFUWW0YEgcJE6LRTrZDQpFJhG3pGCLFgoPIuKa3o=
8B136dJoQvEtek7ZOQFKqesuZKbu4lvM4ds0HOLs5TIgJR_mSJ8UmhP5_M3a1CaDxdDzQ784H3E=
ydkRN9a6v9-Oogo-wYUqS8fRq35rUyw1t2IblmgJzr6aoGazZsJHxBXPjpxA9DSEQqUtH7oT5RG=
M4qxLpEmYjgyzpJUZqhUCSXye7-lCTIQIB-SGzRuZDVbIqK5tZd3F_YK9LcAN0iVH_qfBM4zRe_=
4w4h5ikJdhc/https%3A%2F%2Flwn.net%2Fml%2Flinux-block%2F20210909023545.11016=
72-2-damien.lemoal%40wdc.com%2F

Thanks,
Paolo

> but  bio_end_sector deducting 1 said by Tyler seems to make sense.
>
> From: Paolo Valente <paolo.valente@linaro.org>
> Sent: Thursday, August 25, 2022 10:45 PM
> To: Tyler Erickson <tyler.erickson@seagate.com>
> Cc: Rory Chen <rory.c.chen@seagate.com>; Arie van der Hoeven <arie.vander=
hoeven@seagate.com>; Muhammad Ahmad <muhammad.ahmad@seagate.com>; linux-blo=
ck@vger.kernel.org <linux-block@vger.kernel.org>; linux-kernel@vger.kernel.=
org <linux-kernel@vger.kernel.org>; Jan Kara <jack@suse.cz>; andrea.righi@c=
anonical.com <andrea.righi@canonical.com>; glen.valante@linaro.org <glen.va=
lante@linaro.org>; axboe@kernel.dk <axboe@kernel.dk>; Michael English <mich=
ael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; Varun Bodd=
u <varunreddy.boddu@seagate.com>
> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator=
 drives
>
>
> This message has originated from an External Source. Please use proper ju=
dgment and caution when opening attachments, clicking links, or responding =
to this email.
>
>
> Hi
>
>> Il giorno 18 ago 2022, alle ore 17:40, Tyler Erickson <tyler.erickson@se=
agate.com> ha scritto:
>>
>> The libata layer is reporting correctly after the changes I submitted.
>>
>> The drive reports the actuator ranges as a starting LBA and a count of L=
BAs for the range.
>> If the code reading the reported values simply does startingLBA + range,=
 this is an incorrect ending LBA for that actuator. This is because LBAs ar=
e zero indexed and this simple addition is not taking that into account.
>> The proper way to get the endingLBA is startingLBA + range - 1 to get th=
e last LBA value for where to issue a final IO read/write to account for LB=
A values starting at zero rather than one.
>>
>> Here is an example from the output in SeaChest/openSeaChest:
>> =3D=3D=3D=3DConcurrent Positioning Ranges=3D=3D=3D=3D
>>
>> Range#     #Elements            Lowest LBA          # of LBAs
>>  0            1                                               0         =
  17578328064
>>  1            1                         17578328064           1757832806=
4
>>
>> If using the incorrect formula to get the final LBA for actuator 0, you =
would get 17578328064, but this is the starting LBA reported by the drive f=
or actuator 1.
>> So to be consistent for all ranges, the final LBA for a given actuator s=
hould be calculated as starting LBA + range - 1.
>>
>
> Ok
>
>> I had reached out to Seagate's T10 and T13 representatives for clarifica=
tion and verification and this is most likely what is causing the error is =
a missing - 1 somewhere after getting the information reported by the devic=
e. They agreed that the reporting from the drive and the SCSI to ATA transl=
ation is correct.
>>
>> I'm not sure where this is being read and calculated, but it is not an e=
rror in the low-level libata or sd level of the kernel. It may be in bfq, o=
r it may be in some other place after the sd layer.
>
> This apparent mistake is in the macro bio_end_sector (defined in
> include/linux/bio.h), which seems to be translated as sector+size.
> Jens, can you shed a light on this point?
>
> Thanks,
> Paolo
>
>> I know there were some additions to read this and report it up the stack=
, but I did not think those were wrong as they seemed to pass the drive rep=
orted information up the stack.
>>
>> Tyler Erickson
>> Seagate Technology
>>
>>
>> Seagate Internal
>>
>> -----Original Message-----
>> From: Rory Chen <rory.c.chen@seagate.com>
>> Sent: Wednesday, August 10, 2022 6:59 AM
>> To: Paolo Valente <paolo.valente@linaro.org>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad =
<muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org; linux-kernel@vge=
r.kernel.org; Jan Kara <jack@suse.cz>; andrea.righi@canonical.com; glen.val=
ante@linaro.org; axboe@kernel.dk; Tyler Erickson <tyler.erickson@seagate.co=
m>; Michael English <michael.english@seagate.com>; Andrew Ring <andrew.ring=
@seagate.com>; Varun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuato=
r drives
>>
>> The block trace shows the start sector is 35156656120 and transfer lengt=
h is 8 sectors, which is within the max LBA 35156656127 of drive. And this =
IO is completed successfully from the slice of parsed block trace though re=
porting the warning message.
>> 8,64   7       13     0.039401337 19176  Q  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       15     0.039403946 19176  P   N [systemd-udevd]
>> 8,64   7       16     0.039405132 19176  I  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   7       18     0.039411554 19176  D  RA 35156656120 + 8 [systemd-=
udevd]
>> 8,64   0       40     0.039479055     0  C  RA 35156656120 + 8 [0]
>>
>> It may need to know where calculate "bio_end_sector" value as 3515665612=
8. I have patched libata and sd driver for Dual Actuator.
>>
>>
>>
>> From: Paolo Valente <paolo.valente@linaro.org>
>> Sent: Wednesday, August 10, 2022 6:22 PM
>> To: Rory Chen <rory.c.chen@seagate.com>
>> Cc: Arie van der Hoeven <arie.vanderhoeven@seagate.com>; Muhammad Ahmad =
<muhammad.ahmad@seagate.com>; linux-block@vger.kernel.org <linux-block@vger=
.kernel.org>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; =
Jan Kara <jack@suse.cz>; andrea.righi@canonical.com <andrea.righi@canonical=
.com>; glen.valante@linaro.org <glen.valante@linaro.org>; axboe@kernel.dk <=
axboe@kernel.dk>; Tyler Erickson <tyler.erickson@seagate.com>; Michael Engl=
ish <michael.english@seagate.com>; Andrew Ring <andrew.ring@seagate.com>; V=
arun Boddu <varunreddy.boddu@seagate.com>
>> Subject: Re: [PATCH 0/8] block, bfq: extend bfq to support multi-actuato=
r drives
>>
>>
>> This message has originated from an External Source. Please use proper j=
udgment and caution when opening attachments, clicking links, or responding=
 to this email.
>>
>>
>>> Il giorno 9 ago 2022, alle ore 05:47, Rory Chen <rory.c.chen@seagate.co=
m> ha scritto:
>>>
>>> Resend the mail as plain text because previous mail with rich text
>>> makes some mess and forget to add others at Seagate who worked on
>>> validating the patch as well(Muhammad, Michael, Andrew, Varun,Tyler)
>>>
>>> Hi Paolo,
>>>
>>
>> Hi
>>
>>> I am from Seagate China and face a problem when I'm evaluating the bfq =
patches. Could you please check?
>>> Thanks
>>>
>>> Issue statement
>>> When running performance test on bfq patch, I observed warning message =
"bfq_actuator_index: bio sector out of ranges: end=3D35156656128" and OS hu=
ng suddenly after some hours.
>>> The warning message is reported from function bfq_actuator_index which =
determines IO request is in which index of actuators.  The bio_end_sector i=
s 35156656128 but the max LBA for the drive is 35156656127 so it's beyond t=
he LBA range.
>>
>> Yep, this sanity check fails if the end sector of a new IO does not belo=
ng to any sector range.
>>
>>> I captured the block trace and didn't found request LBA 35156656128 ins=
tead only found max request LBA 35156656127.
>>
>> Maybe in the trace you see only start sectors?  The failed check si perf=
ormed on end sectors instead.
>>
>> At any rate, there seems to be an off-by-one error in the value(s) store=
d in the sector field(s) of the blk_independent_access_range data structure=
.
>>
>> I guess we may need some help/feedback from people competent on this stu=
ff.
>>
>>> I'm not sure if this warning message is related to later OS hung.
>>>
>>
>> Not easy to say.  At any rate, we can try with a development version of =
bfq.  It can help us detect the possible cause of this hang.  But let's see=
 where we get with this sector error first.
>>
>> Thank you for testing this extended version of bfq, Paolo
>>
>>>
>>> Problem environment
>>> Kernel base is 5.18.9
>>> Test HDD drive is Seagate ST18000NM0092 dual actuator SATA.
>>> Actuator LBA mapping by reading VPD B9 Concurrent positioning ranges
>>> VPD page:
>>> LBA range number:0
>>> number of storage elements:1
>>> starting LBA:0x0
>>> number of LBAs:0x417c00000 [17578328064] LBA range number:1 number of
>>> storage elements:1 starting LBA:0x417c00000 number of LBAs:0x417c00000
>>> [17578328064]
>>>
>>>
>>>
>>>
>>>
>>> From: Paolo Valente <paolo.valente@linaro.org>
>>> Sent: Thursday, June 23, 2022 8:53 AM
>>> To: Jens Axboe <axboe@kernel.dk>
>>> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>;
>>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
>>> jack@suse.cz <jack@suse.cz>; andrea.righi@canonical.com
>>> <andrea.righi@canonical.com>; glen.valante@linaro.org
>>> <glen.valante@linaro.org>; Arie van der Hoeven
>>> <arie.vanderhoeven@seagate.com>; Paolo Valente
>>> <paolo.valente@linaro.org>
>>> Subject: [PATCH 0/8] block, bfq: extend bfq to support multi-actuator
>>> drives
>>>
>>>
>>> This message has originated from an External Source. Please use proper =
judgment and caution when opening attachments, clicking links, or respondin=
g to this email.
>>>
>>>
>>> Hi,
>>> this patch series extends BFQ so as to optimize I/O dispatch to
>>> multi-actuator drives. In particular, this extension addresses the
>>> following issue. Multi-actuator drives appear as a single device to
>>> the I/O subsystem [1].  Yet they address commands to different
>>> actuators internally, as a function of Logical Block Addressing
>>> (LBAs). A given sector is reachable by only one of the actuators. For
>>> example, Seagate's Serial Advanced Technology Attachment (SATA)
>>> version contains two actuators and maps the lower half of the SATA LBA
>>> space to the lower actuator and the upper half to the upper actuator.
>>>
>>> Evidently, to fully utilize actuators, no actuator must be left idle
>>> or underutilized while there is pending I/O for it. To reach this
>>> goal, the block layer must somehow control the load of each actuator
>>> individually. This series enriches BFQ with such a per-actuator
>>> control, as a first step. Then it also adds a simple mechanism for
>>> guaranteeing that actuators with pending I/O are never left idle.
>>>
>>> See [1] for a more detailed overview of the problem and of the
>>> solutions implemented in this patch series. There you will also find
>>> some preliminary performance results.
>>>
>>> Thanks,
>>> Paolo
>>>
>>> [1]
>>> https://secure-web.cisco.com/1hcxnN1C3h1nW7mby7S66_LE8szirQwbQI0fBpYeP
>>> rA0GTWfyuQyl0GpZaOn32xMSkNT0BUQWloDHFzZ23aYDZdi8NfdrEFLY9pQDBblIvn08LR
>>> iTVoIOUC8zWSG_r2PCyLtx3ppZq5cWOib_8azxteRRcbKWGdbLPSqg9hfSJSqltth0ByLO
>>> NHEoI3p3e9QNIn6nVAeQbsT3aOQe-F95XrQvaPrFJXx6RGL9kDXyfkbXIHcdcLBf895gYB
>>> Fn5S2WjBDQq2kzDzZOlc1HekRUhg0qDQcFY6NydVfrqNfLbpAHAth6KyREscQhVTMVREEV
>>> a1b6bQByX6grF5pn3pTIo0lODyfX6yRmcbReSYNfOZ65ZPvp-nH530FQ-5nXoRxFf74WIK
>>> DrNTALs3xQvg03DH4jLez-T2M9xEu-sfEDAEdTGF7BcnmBW6vrPO4_p3k4/https%3A%2F
>>> %2Fwww.linaro.org%2Fblog%2Fbudget-fair-queueing-bfq-linux-io-scheduler
>>> -optimizations-for-multi-actuator-sata-hard-drives%2F
>>>
>>> Davide Zini (3):
>>> block, bfq: split also async bfq_queues on a per-actuator basis
>>> block, bfq: inject I/O to underutilized actuators  block, bfq: balance
>>> I/O injection among underutilized actuators
>>>
>>> Federico Gavioli (1):
>>> block, bfq: retrieve independent access ranges from request queue
>>>
>>> Paolo Valente (4):
>>> block, bfq: split sync bfq_queues on a per-actuator basis  block,
>>> bfq: forbid stable merging of queues associated with different
>>>  actuators
>>> block, bfq: turn scalar fields into arrays in bfq_io_cq  block, bfq:
>>> turn BFQ_NUM_ACTUATORS into BFQ_MAX_ACTUATORS
>>>
>>> block/bfq-cgroup.c  |  97 +++++----
>>> block/bfq-iosched.c | 488 +++++++++++++++++++++++++++++---------------
>>> block/bfq-iosched.h | 149 ++++++++++----
>>> block/bfq-wf2q.c    |   2 +-
>>> 4 files changed, 493 insertions(+), 243 deletions(-)
>>>
>>> --
>>> 2.20.1
>>>
>>>
>>> Seagate Internal
>>>
>>> Seagate Internal
>>
>> Seagate Internal
>
> Seagate Internal


Seagate Internal
