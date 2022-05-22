Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E41530670
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiEVWO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 18:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiEVWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 18:14:55 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01on2062.outbound.protection.outlook.com [40.107.107.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF03839802;
        Sun, 22 May 2022 15:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDvKFUCeogIPLCTLVrOOPSuCnhefJaRd3bugMP7JuWKzCMcpAQViC/tTtbBVYv7jeErQewslvQDYvzLToyVB3hYXOFCVd6rIc0B6M2zHsBAI3U90RGZUsFFiVsekQ4zFEdh3J+q/Ukyxxbf4iTKGtqp4SP9fYd//7xrOVFSA1Qenkixss8wCAhrz4nnp96LgXqUkhx8DC5Yxf8dLNgSuhEBVpfYvUWOEyU1ielDzcDYjcEErSAd7yKhRQ/KjTHRBuwY6rGJpg8xQPA5JtSt03gsIjEazJcVY6TDGUutO9iz7KNbLgT9PZophBj3Z3AjcwdENOe3L4OH9LQNlF7+Wvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1b73iKfFWuqYxIC9Y5dejaziDamuNNqiwgQUf3qToI=;
 b=cRdW5gnTq/aiTVnv/ebuwG91RCc8MafqKLTCefVLRHaq8EgmkmlqbgPFUQDPTMPeF/zR/RAmoFl6OcvDz6slb404r+wOmxth3+9bUMXOaQiD8zg8/LHf+JNARVMOdzwBecClP5k5l1+99UNvYnwzdkjhrh5dVMhLPXqo8irC/CLCagAGVv1sAJLqa/dIqyAHIlGSGIbfLhnUdB7MQW3ckUG4zm5PwlCRLYs0TC9NQDRwECBVex4iylO2B7RZxYS2WX8npRchfgUF8fBOhVTaYXOFUFGOlL+6nKTjWaGPUl752EpYfK32qgAuRSMx1CSOSeoPHgwTD0xmwo+Fkh3XIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sydney.edu.au; dmarc=pass action=none
 header.from=sydney.edu.au; dkim=pass header.d=sydney.edu.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sydney.edu.au;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1b73iKfFWuqYxIC9Y5dejaziDamuNNqiwgQUf3qToI=;
 b=Ue0rZ9/NlsTa/DIVF0S/1OiT8kWRMP7IiYdZxEJ2lvcsDO/8BkyAYXpBov16N4Xr3iavRuLfgUQeWjXUs2GZCX15E+hznv1qKIxbT1iKemB5OZb0Z8c7v7LT1FRIAl5TAbzBb2mNZfQlRwbW0Wob5JqK6zOdcfU4wCFaQvubs/9DDQuLhh4voM6z42ng6i4ROCtZNUaj/IJUtXcgYPIqd2dMykA+UklzNh+S/Qs8Jpp3gOvT/EoDEWOBptpn1N2oU5hUngjxAMZZQbbaBx/0RbaPqmoBoPHuDqZaqlDGlGDP3YZ+YD+OUx2b0HwGv6RslxEyXYgqvjBXmfxgR8+9Og==
Received: from SYBPR01MB6620.ausprd01.prod.outlook.com (2603:10c6:10:12b::7)
 by MEXPR01MB0917.ausprd01.prod.outlook.com (2603:10c6:200:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Sun, 22 May
 2022 22:14:49 +0000
Received: from SYBPR01MB6620.ausprd01.prod.outlook.com
 ([fe80::ace9:d5c7:2f9e:7e85]) by SYBPR01MB6620.ausprd01.prod.outlook.com
 ([fe80::ace9:d5c7:2f9e:7e85%4]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 22:14:49 +0000
From:   Tyson Thomas <tyson.thomas@sydney.edu.au>
To:     "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: [BUG REPORT] perf tools: x86_64: weight column displays odd memory
 latency data
Thread-Topic: [BUG REPORT] perf tools: x86_64: weight column displays odd
 memory latency data
Thread-Index: AQHYbikBqoNARN6xu0+kyVhcP9zLfQ==
Date:   Sun, 22 May 2022 22:14:49 +0000
Message-ID: <SYBPR01MB6620E2316BDF9CE29178CB32DBD59@SYBPR01MB6620.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: b8140c5a-3b5a-5a55-b6c1-813f23474e3d
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sydney.edu.au;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13b4b70a-5821-451d-ad56-08da3c407cdb
x-ms-traffictypediagnostic: MEXPR01MB0917:EE_
x-microsoft-antispam-prvs: <MEXPR01MB0917E5D37AED21409B2D81A6DBD59@MEXPR01MB0917.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ER9VFcwmPq5Z1ERDeiXg8Y3neW0WMAYht+jSxldyFxb4b1yVZsqCHHcCXlxONzE1tFSJ7ptjXJLxdM6CnawI8a+Q1ZuQ5PJhaJGBl3vSAV+x3olVvi2M286EcmaMGYTsR+9Bk6NFKrsdXv2NBEYc2yBT1EBfswNvRw0mLldUiu9rspMVXK+IOBhV2DszeDqZKQ9QaQP8ahbsafZ4u1BF61WzppOoNEWcw6sOxINKrUR/gEwcdos7whhq/Otw6aPeowold1ppx+s3UGgkwAvSysl7qGRVY/haxhd+1fdczUFDIcNWmsVJfJtZD72ZgT8AORkAP40yFwfp0kz0cDn7SOjgZa43QFisFGsDv5kyts/IGwaZZt/8TsQRTwONskIwu8A0nkFJjUDanSbBtCCaQk4fMw04xPCWl4mgusG+qOab8UkOnUWTFs+SikwYFoB8qE3tAH05DzNjx7GsZ3t9jTpAPjRxEpNapsJogwa+lMgBDAubjSNvx3pXEJloQoP3e/j3BJzuXNNA0cw1/Ee5jqa0CCW0vGRVDZtgv4HNUEe7XaOFhLpIDJpEP1Y7WCcGcMDwvGEOvMS3qkMYhLhWwPh6WGiBo3kHCc7BwsPOEpy5OYrb3vpSuEBv1Byl+SGKuEL/93p2zT74op1aHGIiGqwGCrpBf0sAspHzfFu+iMp+sIkgMo0pH3Ul+V3VhdQz1ECx7+n1NqJ4ex5bpvOANg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SYBPR01MB6620.ausprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(33656002)(66946007)(83380400001)(66556008)(66476007)(66446008)(64756008)(8676002)(76116006)(7696005)(6506007)(71200400001)(508600001)(55016003)(26005)(9686003)(86362001)(110136005)(786003)(316002)(38100700002)(44832011)(5660300002)(38070700005)(122000001)(52536014)(8936002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2PC+vChSQPM+dIHcS83/pRB0hXKxrc38VgVBcT83gwx8VlgvGZfjMKbFQA?=
 =?iso-8859-1?Q?RPClONIy48/YsYZbMSopkolKf+iYj/mmq486soicOAtXtkbOic9cQoyEwZ?=
 =?iso-8859-1?Q?cSU7A/ESIGuYfXqEIBmWimW0ucwXhQyn7nV57WWf2iSSugVzEuIYPPec+g?=
 =?iso-8859-1?Q?7lmWFl21qibbYljuikpdvVCpFIYk86oVnLKy4l9GblnQO4O0Bxu0AYpTkR?=
 =?iso-8859-1?Q?eZkwXeCv9WToZ5FsysxMcveGpV53mIONmf8SR+bdIe6UK9v/J6MgH3Nyqn?=
 =?iso-8859-1?Q?jlGHF24v3D282Cf+HjN7OZwp41fQUZSktbdzZAUTo37bCAm2s39f6nDMDV?=
 =?iso-8859-1?Q?8wx2UkV18NYS3Mg3yi5nXy/ol8880KCuIwEfwZL326eU6CtSt1ix5FXLsd?=
 =?iso-8859-1?Q?elco9/ruDnJqkLlscVAvOlZ3n9rGWV3vJ3RKNv036g5tweqYqHMjMDOOY+?=
 =?iso-8859-1?Q?w3pxBxd9Cozs0ptCWoz4sX+ixYddVNJS25fGLQuCC33X06k8YckB0ShP/e?=
 =?iso-8859-1?Q?HuDLTJY2ujhWBVTznky+PcJzQ/asCuvrAZCdnboFhX6A5pyXsWj/dNvOJ3?=
 =?iso-8859-1?Q?8r7/OerVfbli5RCAVLTU3btUROJx6JOOV2vM9WSFE8FMcd8KqDTXAF1vhP?=
 =?iso-8859-1?Q?Ghq18VMa0oOmWMmRtCWqukzRhlPU80WZKWGjkjOmaFy6GYp4SuJEGRHKZ9?=
 =?iso-8859-1?Q?Q/+1hNqFumdYwNnlb3WpqvdEF9SZNtO58dJgWm5ra4T8Iik7zba2j59ggv?=
 =?iso-8859-1?Q?pRLSwGJi+BfvuusmBr+yFWhy5P5DZMGryjLfAfbMfly6JDJeQUc4rjQ16x?=
 =?iso-8859-1?Q?8ED6w/AHujIQUf4SQtVzgKUwi17Y+C7YcChrDF3WJ3KeawhdDC8ZBSaWKy?=
 =?iso-8859-1?Q?1ahR5bNGQrHErEkdBbue69DpEqY/owPQ0LR0sZ7CZyve3TXAzdq3yYPBNm?=
 =?iso-8859-1?Q?ZOIe7p8LlBJ0bM6yXP4THjy1F80zbuJUkkjhXHlBKVh3RgdjR4f9AqgQBv?=
 =?iso-8859-1?Q?9pZTSi3vNPu1ISobGnsv/UXAbTzYmoaADF2h+AfaC+HMmXmcSPJ/JalGDy?=
 =?iso-8859-1?Q?Z/CKvIo8bLDFh5Y1M/FMyWkeQQlRo8hhPFt4Vcl118gzXj8CE875FLjkgl?=
 =?iso-8859-1?Q?DjQav7Hn5jjJRNu4fUpGjBcU72UZxAlKGcqbcN0pooss1kGQg7gsNOlyxL?=
 =?iso-8859-1?Q?Yfj8qaq+tvVjJwm145f+zryp3/YMnWpRrbF/GtFj1F6KGGWUi/ISXx9hMg?=
 =?iso-8859-1?Q?P8zxkpwb6wPUfc7bToVjExzOr3+EV95wZS1OmRj/Ac+MSRolFGzx5jwoR1?=
 =?iso-8859-1?Q?8h58KMKa+daGLzzu/3lIWPYdfjKa+xfRaz3Pd7oT0oz3zwwP4eyBd30lMb?=
 =?iso-8859-1?Q?oFbM9wJpOt8OXz7xhxQHzmSapHsnZJyNdgLRmSkMsgPCojh3KU3tULVPth?=
 =?iso-8859-1?Q?cxS+NtoPYOYbFlO83rxJ69p5HUaGOwlDMUerwNpuEFx5Hdvdk6d3VYHxYJ?=
 =?iso-8859-1?Q?xQCSenZ/pkrb5prPHU4ITpq4jUd1Cal5rD2iNIi2D0tlBa6YunyAUb33Ry?=
 =?iso-8859-1?Q?mQYz2FTtBMgKrROm7Yv/bsJ3yjhxBijfriN/5cpXIHF8A/LXPWBCPfbLyp?=
 =?iso-8859-1?Q?O6IrwKnSO7ZmqbBC6qnOKWVxF1AfJFQqqJSO16oAb/f862iEBMIW0TYOEP?=
 =?iso-8859-1?Q?O+gdYYCBXeJentT9dwXiIv2o0j6PjYvOtyzB2zn+SAkWg+jyqUCPSqJeHp?=
 =?iso-8859-1?Q?OhMiqu/bIglydNrOZdg4RcLG+3BqAOvLresaGpYFAUMn/MCy3B3VljKmS6?=
 =?iso-8859-1?Q?hFhf0cTh5DcR4b/eJLv4uMqr5vOIyEc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sydney.edu.au
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB6620.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b4b70a-5821-451d-ad56-08da3c407cdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2022 22:14:49.6222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 82b3e37e-8171-485d-b10b-38dae7ed14a8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9kB3nkhuhUC2avJxGGxBH0LvkxlO34e1CvXVuT8TpSWYi9KxVwTLIhHTwuigDs5MfHsLFoxMce/yS3D7loC2NkDfOJADmVszSN9GeLfb7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEXPR01MB0917
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan, Linux-Perf Team=0A=
=0A=
I have observed some odd behaviour within perf when using perf-mem. Specifi=
cally the reported latency under the weight column appears to be unreasonab=
ly high.=0A=
=0A=
Here is a given sample from a recent test, I find that some of the  latenci=
es are close to an unsigned short and I cannot seem to be understand why th=
at would be outside of it being an issue with the perf events.=0A=
=0A=
This can be replicated using a NAS benchmark, specifically cg.D.=0A=
=0A=
I observe the following results in perf mem report (just getting the top 10=
 results)=0A=
=0A=
=A00.02% ,62515 ,L1 or L1 hit =0A=
=A00.02% ,54048 ,L1 or L1 hit =0A=
=A00.02% ,52206 ,L1 or L1 hit =0A=
=A00.02% ,49831 ,L1 or L1 hit =0A=
=A00.02% ,49056 ,Local RAM or RAM hit =0A=
=A00.01% ,40666 ,LFB or LFB hit =0A=
=A00.01% ,38080 ,L1 or L1 hit =0A=
=A00.01% ,36772 ,L1 or L1 hit =0A=
=A00.01% ,36729 ,LFB or LFB hit =0A=
=A00.01% ,27101 ,LFB or LFB hit=0A=
=0A=
Is it possible for someone to shed some light on this or am I misunderstand=
ing how the weight column is used here?=0A=
This appears to have been an issue on 5.4, 5.10 and 5.15. I am looking into=
 seeing if it is still present in 5.17 and 5.18.=0A=
=0A=
I've also tried this on different Intel CPUs such as Intel Xeon 6230, i5-11=
35G7, Intel Xeon 6330=0A=
=0A=
Any insight or help would be appreciated,=0A=
Tyson=
