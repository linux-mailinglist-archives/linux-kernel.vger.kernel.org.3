Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95145578A0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiFWLYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiFWLYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:24:04 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9B349F87;
        Thu, 23 Jun 2022 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655983443; x=1687519443;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Dv74wVhnMg6ZbWSbJItSOdrnOUUw+YlFASwpvCsparg=;
  b=piC+Lwrn/GeS9sPsATyNYF4/7IiLySfBdD/rq+llmoJ1lJtta36n/tPP
   S1KzHRMPF/IFoA35EqYB+uSzyG6i9RGZEe1iG45z3/l9YKZywNO4A/0WY
   /ZE8LshRcj9NLl2iQ8KUdzkk0beIHcNqI6GWsuX/66X67B0Ut5JiaQDdh
   QY5oxBUGnNHWl6r+YkmJwhciehny6UTk3lt80jK3kOSruX/Kb0Hi+gAKu
   EAMktoGY4DyYbzMv8+/Gg9eYhlThueRmAUTM5V6eDinm8wW8BLfg97Kd2
   JIWGOvqxIpKFXD61+ew2FGLpr2a6WfSSJcKQSI6eHoHUVr6OpICK+Cr9C
   g==;
X-IronPort-AV: E=Sophos;i="5.92,215,1650902400"; 
   d="scan'208";a="208776104"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 19:24:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8mbuQioN4PY/Z5wRgZ+eKo2TtAcOvqo8jL/hd7XxklzOiZNNt1Akin3vPvU7AZx7WCA5y+DyDai1L91918KbhK+io1V3jUb3W1h9+1AJS6svu0UlU7jhYwGUUsxLRRcfC4JACzOFwgfxf/rqm+lw9hcq6Lq5I5U+y6sivnwvP5LFmB2pOaKyVAeTJwhJlF2CX4VxOgJNPo+FMCIXXlbDZlpSlvbhnS5HDcjVXLz4sd6rv0KtD+0wGgIrtGlDikpvg7SBZGW4GJjgDnC0UeDoUoVvOi7f0l+Xcg4yf98kJCs4BYKtpgnFeR/EsVKfx81nmcs7xoDYpVad+3/Rcah3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTJy1Tp8/2AjBWnotcCTkvWkjKd9MTrnAeIDVah/lC0=;
 b=UGTAvMaiESV1U0GZ1mA2ACV4fxtF98AA5HxGvnDXHi8FZFfccV+QXGjZxX3F97FnapSiQUznUvsiMkCuQE3mIm/ZhsAxpMcqMO5+JlxecCgwieIOdUcZ2OMvqwPPo+qAz5yV/FAoTAQc/nGK3Z+Lj3/p7kyUsj4cfT1bP+ns7r2rbOc+/YYxLQf5hloCsvbTT6+TEiGT1+4JxMWbOfn28k+MH+OFjLVZhF5oaGIcXaSeyNCzUMg8biEOXFMn2nUXn8A2k6xsZcoQIf9Bje3wFZyljj4Iq8lIANb/u7OGLrqGdapk/5Pmid2fZ7Pcj1tKvKPeeg05YoURQht1VNSShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTJy1Tp8/2AjBWnotcCTkvWkjKd9MTrnAeIDVah/lC0=;
 b=akhphMSRwJ2CzNv/BKmVXAJ2+xN7syf+XNzDLLCOpWeYRuWq89rSkCi3lWGGXqiefLgx/gWB1w96Nw7IEuu2DIjzQyyNH5b9jE29OJX6VX7umdu0rP0vU2onwaeuAhFJ48oyGZGMMogFYfvb8CUKipr/sHb2UURpLUBt7fuR9ys=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR0401MB3568.namprd04.prod.outlook.com (2603:10b6:803:46::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Thu, 23 Jun
 2022 11:24:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 11:23:59 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [cpuidle,intel_idle]  32d4fd5751:
 WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
Thread-Topic: [cpuidle,intel_idle]  32d4fd5751:
 WARNING:at_kernel/rcu/tree.c:#rcu_eqs_exit
Thread-Index: AQHYhvO8OeGtfqrIJkyBrsneRAjEHA==
Date:   Thu, 23 Jun 2022 11:23:59 +0000
Message-ID: <20220623112358.chwk2ld6k6sufeb5@shindev>
References: <20220612160006.GB35020@xsang-OptiPlex-9020>
In-Reply-To: <20220612160006.GB35020@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17651eb2-8a24-4cb5-22d3-08da550ade8f
x-ms-traffictypediagnostic: SN4PR0401MB3568:EE_
x-microsoft-antispam-prvs: <SN4PR0401MB356805B80BF0A42876864000EDB59@SN4PR0401MB3568.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mQtqYYbAoQEJAKBTID/mKVVrKo/alcyUkakjyJjyuaMiPKjxoL78l2PEPLqhjYujcs/RmaulzquQT5Gr4chvs2bDcNdzLc937cdCpB22ktHC2C7VyQCWFcEwXI44hys6EwN9Iu6584CSn7NgpXOPcuo64AB6T5PIPiZ1U8gyOwJl7CnmKmV//rg2Mrv5fTc4jZQIm+otS7itpbb1WLAUagjStCFARTXs5aRO5md5v+qJTFecubg7yD2VHYca9adWjip/mcSDZ/OOXiTnCNWtRSPCatF4rjLpiRZ+Yo6BmJHEA3xKvx8Ks/pZYSamjZNjhOr6O9AvFjkHO5qMiIXpGZxPOEm49A/uXARYYe4RoOB2M0EmJs67QNy5sJ6kjcFRfspfJ62jBKN5/9Q1u6QEuTW+ud8EKHgVm10/Z0b10oWmorlkENeVD66Tmo4QlD0EfmvifhdX9GdZEitKAhXJ8aVrciET+MZwCENLzMx/sHRRjYLDjGuaMRJtYIHo3nsRFmC1qJWdnKvA8JnuBZrKJn4C+Ri8tASnLIuXiQmQfIOxNaU+UhGxartDu4IWJOuP1V6S8bqrUHnFwGchpPvoLpQW/2a2flSYThysAcWi772HcC5ef6FmbQdk+HziSx4Fdiem3X55XrZFHzsPzjQYQld8qXavFfTF6vAB/1I5S3av0Og5f3uzqLP5NT+a31zLVSYsTB2j38CPYTYd5OaAXVyN+ZENq9Y6gGkroRVUNoHknWVPgTC3DsFp6t9hTVGQ1jJmVd0rXfNlNLl6Ox/KM+DchWTitHtgwxPzrXPXtRs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(66476007)(91956017)(71200400001)(66446008)(6486002)(4326008)(8676002)(66946007)(9686003)(76116006)(1076003)(26005)(83380400001)(54906003)(82960400001)(6916009)(6512007)(66556008)(186003)(64756008)(38070700005)(8936002)(41300700001)(6506007)(966005)(44832011)(33716001)(122000001)(2906002)(478600001)(86362001)(316002)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YO/viTqemkveRFpeDC6JUj+SsLzW9k9K9Hw53DW4Doh7vgOW40XhUT4hqOnu?=
 =?us-ascii?Q?mzhY27+RY0M3/3Wl4VVHdNNCDrvqdi7AXuqxuRXY1us1doHY8RcDu9sfCIUR?=
 =?us-ascii?Q?F8f/Pte3NkPdfIAnGMc3dNT7RkDUMiayAnaDcUKV2dLnO0e32GlFiCKrbclI?=
 =?us-ascii?Q?hqMOgTjMyHa91YNYPQzExQaBMg/ev4qoD0QJWp5VWkQvoF2ezBNgvjyEEwtw?=
 =?us-ascii?Q?sF//VrZKkem2hmiqomBITpJleRJR+gFyHrzxp6Kt2+fPY9LgzN1IKnnKWi31?=
 =?us-ascii?Q?dPZfGP2ygXtcX3BYQtZZML0YhYuJNroBWiEynou40VKJw5EyFB6fniQGgIrm?=
 =?us-ascii?Q?r+ihhzfbh+1khHqlBnEQL86b+bbDDNRY1J64OM5E+wn9VHv1oGxpoxjAsVrb?=
 =?us-ascii?Q?NwB4hVZc3sp9Di5kDTGGmZl/zb6K+MCkYBiNw6H8EXBV0UyWwl0VozF8g5WQ?=
 =?us-ascii?Q?ZrLWjb8/AdPBvA0EDy2No1Bhwn4lPQqOrlDMaBWjiH2ljsNDG5uMxuANKUAZ?=
 =?us-ascii?Q?ri/3akJe18f5BIG0rA3moa9cso9CVmuvUdx419y0SRzv8XAxAVB10A7P3+fH?=
 =?us-ascii?Q?aKd81UzuRbH7iSG3cQjq3OSFSGSAl4PuxWO8eEz/ViIwm11N8mhX51wcLhww?=
 =?us-ascii?Q?gmI2gTrDKzCnMP06fl73Esis8qJRx2wbhtghXnDzxasffk4FM7tqmajeQAH+?=
 =?us-ascii?Q?NtBuVquBKRXmxSTvNV9IKS6+axBa2uEpHJabm/3MJKImYtNiA59i/fe4ng6n?=
 =?us-ascii?Q?4rc8XNadJ8rqvXiixBfPAlZc5qgclNTbbiSyzZZ7wxneoNfh5K/6OtGohTlc?=
 =?us-ascii?Q?dUi+jYvk3f33ETaKljSS3d/20XegmmYl6zudKzl9siED/UhoVhyDoMHlLlQm?=
 =?us-ascii?Q?Nbqooet1DWNkXJEsoQ3swQRmUx4MYdUSJMOnNM5dDekdjYKRng86C89a2WDw?=
 =?us-ascii?Q?FBm6RrZUIMlNBshLx16SO6CKR1/2eiFDSeORCZisagYbzdspY3SwT7O6NBUn?=
 =?us-ascii?Q?6+h+vlKFSLqnNAO/8/rRaUjpdDp2U9AbGlIjaMpBKGXWfRUaXCWNHRV1ogHC?=
 =?us-ascii?Q?z7S+8s6miweegoujbSx9cvFjvtyjNQJr5kDZEvHMdAnwj+ABlfuQXXbqTGkp?=
 =?us-ascii?Q?ZX570mJRPV/Akj7aL+iqY6Rr6vHL1i2QOXItDFzRxC3CUEKNQjebfa0uJeTe?=
 =?us-ascii?Q?2zWra7+8nApmoWty82sWrqwTcTkqXId8M+U/y2zn7fckUzzaQInJwn+xpzTH?=
 =?us-ascii?Q?n7GMkHmIJdx9bUantncsjNLOFf59Fav/rsfYBxadfwZ9aiddRdfyVDSK5J7F?=
 =?us-ascii?Q?6U291pL0Yfh6/5WDUgUS3rqaws9UqoUpyXiD2HOmQsbzj9VcwA07yfegEnpk?=
 =?us-ascii?Q?+fR4BxWD/VFkn3HysNU1yCgpuw+WMg21rZUaxEtpBH1CDyLHsYn6m4M88/Yo?=
 =?us-ascii?Q?UvyYh90B3Vdlrr7rh4bMZNlmMXVIUEEQ01sdvzzs5XQlC33GFB/5rQXBaojo?=
 =?us-ascii?Q?ccQRzenEeI99aV/bbJpTMSp2PwukYbvyghYFZEYWiJuImqBbsCR7vskfCli6?=
 =?us-ascii?Q?QzYoZmeyLVZJDhDej0Xub/1Ddz9E08TL3qfmhEYJHrvFXWMqsYnuOxjjLBp7?=
 =?us-ascii?Q?lwAjAJOFtNu5LwoZ+oJvaUR71OiNloOk1lpObQM37r1GWTKAbdaDfjBkU+gk?=
 =?us-ascii?Q?aC1g0fXv+IHP6l0gZPuPeAsLM6G9t82J09pkRlOCTxkxOp/z8frs1KYkIKWO?=
 =?us-ascii?Q?YKn4nvCxTA6Ois1SYCU320SR/vEydVT2ZBGyRBTvpp7ADNR4R3oq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08D4B58D6329A04B96D6B37758075BDC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17651eb2-8a24-4cb5-22d3-08da550ade8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 11:23:59.8147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9W1ttwfm19iWlwJnlnMvyWtHdpKKEjzZ2QU6bxHbr+5/8Vv12Odz2gXJEQt7TOh8xIDj1t4nutwVWd0ceAPd1qusjzEk1qBoPj/8OFvX8/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3568
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 13, 2022 / 00:00, kernel test robot wrote:
>=20
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-11):
>=20
> commit: 32d4fd5751eadbe1823a37eb38df85ec5c8e6207 ("cpuidle,intel_idle: Fi=
x CPUIDLE_FLAG_IRQ_ENABLE")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-cef46213-1_20220609
> with following parameters:
>=20
> 	group: resctrl
> 	ucode: 0x500320a
>=20
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>=20
>=20
> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU @ 2=
.10GHz with 128G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> [ 29.104402][ T0] WARNING: CPU: 0 PID: 0 at kernel/rcu/tree.c:864 rcu_eqs=
_exit+0x4b/0xc0=20
> [   29.104417][    T0]
> [   29.104418][    T0] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   29.104419][    T0] WARNING: suspicious RCU usage
> [   29.104421][    T0] 5.19.0-rc1-00001-g32d4fd5751ea #1 Not tainted
> [   29.104424][    T0] -----------------------------

FYI, I observe this WARNING on my test servers for fstests, with kernel
v5.19-rc3. It was observed at system boot, and was also observed repeatedly
during fstests run. I reverted the commit 32d4fd5751ea then the WARNING
disappeared. The WARNING was observed on systems with 20 threads CPU, but
not observed on systems with 8 threads CPU.

Looking in the commit, I'm not sure how it is related to the RCU warning.
If any further action on my system would help, please let me know.

--=20
Shin'ichiro Kawasaki=
