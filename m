Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2356A9C0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiGGRh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 13:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiGGRhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:37:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A1833A3E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 10:37:24 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267EgEFE004392
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jul 2022 10:37:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=QBGu/tq+TM0IUXv6P3wuS8ZRFNNsYydf10IqYg/iCZg=;
 b=fthUwtNEbuN4RivGOaVwf1Pq2Ur20vP3OwVLiVpgutrNv4HmRj7gOZLpuI1WkdS/HLFZ
 EzNkuEBxpC/1ExQWZ6GVU9xLUuqyhWpjILbr9Y3t5fDy2Q7yWPxFc+10ol3Vz2cPd7T+
 zj9vpnLIE1WJfTtrnFc8W76t/seE7MphrhA= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h5ashjcp1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 10:37:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3P8S9/sdQnlsCfy/1V7EXojSqobEzc4vKL7O361O+6G7y73s5lSPCryEOiDgLbAe/IZj2gDZUUuXWM6tRn6oX9Ot08rEfy8aj3keB4Dyl0judQN0So2L6XbKR3syhtW+e2pSPHOpbDTd8MkKO482HLLrNRdZqmY2VCVWkQ0RffRDfQlGVetQzn8GGxNqeXEQktbUsNb1pXMkMhZA4AWP2Mi6pVF08tcQDdo+gTK0DmaOGG1eTH0b/UGL3Bg0S/yDZACiHOglI50Ocb9hksGRXdMLoOimI+g3lE8CHfbqLplzT5g0PK0ECkT6uMeIiaC1r3m2WhntkxNF1mxdWo8ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBGu/tq+TM0IUXv6P3wuS8ZRFNNsYydf10IqYg/iCZg=;
 b=Xtp8otIsOIvQGoy/ZsdOLss3ubqERsNgw7RynOdUtgEBIoGrCA6vsLYEfG4PnocLm7kd1Jol+JFO7gXoZRmpVeITI06b6MDAzTFpYNjmhNMPRhRnbQIjFKq7E8ZRfv2XyEBjJTmkaiqfxTqR2cb3+Sc6dnr6UvX1fvYjvaELQ6TbKUnWRtwVJ7QdsofcRgbfeeGiUi+IS7jCjQKtB+9+DDWYUDqWljd9h3C1VuINCkFHG4JhNUWZDpzKBjkG4dRdfYZqxMBchgRt3nWujcRDczTSZBzdNTRv0SRwqJaKbXCfeHk2mWdzFXGHz+D99aFNfCrJiDYuQadWnxXGzAOAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by DM6PR15MB3626.namprd15.prod.outlook.com (2603:10b6:5:1d3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 17:37:21 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Thu, 7 Jul 2022
 17:37:21 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [tip: x86/boot] x86/kexec: Carry forward IMA measurement log on
 kexec
Thread-Topic: [tip: x86/boot] x86/kexec: Carry forward IMA measurement log on
 kexec
Thread-Index: AQHYkiH4JPbBMg4J5U2KvaHM6yRn+q1zK2uA
Date:   Thu, 7 Jul 2022 17:37:20 +0000
Message-ID: <YscZM+N77zUb1uam@noodles-fedora.dhcp.thefacebook.com>
References: <YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG>
 <165721275237.15455.6157055713679490274.tip-bot2@tip-bot2>
In-Reply-To: <165721275237.15455.6157055713679490274.tip-bot2@tip-bot2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a482d8e5-3328-4e2e-ca66-08da603f587d
x-ms-traffictypediagnostic: DM6PR15MB3626:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oEVIItXwPeP0WYH5DaoPP7oeRseZhr6TzhwiOyMyLIrkzQtUNOBoPOWAPYLT21IeGHVHMaiYdn8rMT6hJBzmHgEFSLS6TF42A6cV7e6qvYGoOER5idJ7eYbVC60+4vtaKvDriUWP8OP809ikqqmQH09yEvwsS6/11foFn9PzP9i7mcMXiufz2xeyTKB4kCBUqGM9TzjG7H9Bc89afi6g5viB31BPORcZVV+LeXw0EGZGxPm+tDIBEoRrT8OSLytFgD6OTOVmrzMdqgtVgqDrSteWHp5uY6wMD5gsbwUdhd/X4Rsu7F4Z5SxFxo4+pggjWTZ0jZBzYoKDTC0IqolBxtlL3i40I/94V9C3oWFIwUfIHimibm/jEEgOQip5YKl01zxat57cFdMkpl2/3F1NSAEXR699Eww7fty07cN+4g+FYbUEuH8Yf+L6aMMO6UN82/xPsk9oPx6FzMS8zzwrSFSO0pvW4iV+oTeX7UKs8KtrSzYAyelXH+JSWbjQZXj89P4nL2fadcXc4/8JlVRTCGKoqORuhNFa4NGjkyxrdJamni5Y05YjJHofwWj3ajYQRxFHBx8/E37N92YdzlqbRFXXXF7pYvVfRd6ewzNQ4WbH8px5K9qfIgNfA2q6/sN6QuDH+Llo0ZengYORag8/mQQYUodRbDXKdA/h4WsPxwJzAb8E9x0fgixK0ZbtzPC+bEB8ZJ9Yen6LZt1fazCDDIoTfPfQRJZa8IFB5RsSZP/IN+ZGa8xJNZ4cRwqltYxmJDvvJvJXwN27pXlaqkx97HBhIfaAUTmJIR8aN2QGCY1ia+JDzFn1qbCpXtRm59w20VMNOfo/OB+lnfXgyfkZ6PqEl6xqUWiB01j7COXO4vijkWAhMgwGRN1RKO0+GlM3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(186003)(966005)(6916009)(64756008)(6486002)(83380400001)(41300700001)(9686003)(86362001)(2906002)(66446008)(122000001)(8676002)(6512007)(5660300002)(8936002)(76116006)(91956017)(4326008)(478600001)(38100700002)(66946007)(6506007)(54906003)(66476007)(26005)(71200400001)(316002)(38070700005)(66556008)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lI1DuchM/7UsQVHHdjt3zKnspYJiJ2Gesyd9fSbtQF2gQtGYlN5q8Ww/Epv7?=
 =?us-ascii?Q?7debk8e+FnJehNvAm26ybC5F9OE3rCyahUvER7QmnI40wxAd9qHb/oizsrtk?=
 =?us-ascii?Q?rmRy5q/21fizTOiaPpkU1uVEJM8HDFDfVzJcr8jKRKhUDJ5h9nyGWsmy/cnY?=
 =?us-ascii?Q?v0ENN+H/mpeUuC3RBmhpdUB9lmoCbZ4UILioYqN8PvPAoBDmc49rxY1xVAA6?=
 =?us-ascii?Q?gaMKe9ofcxw+0LynQLfO5/ZJDn7T34xHd71vEZDy/Agh83fw8gaK0okExdKt?=
 =?us-ascii?Q?k+/ZbTuUp5ygEQetupLONZQa/DORkB9MeYzLPepIUbJMRKgswuvYtf7CsLWh?=
 =?us-ascii?Q?AnQq2a+5Jnw4GsbOIBapUjDgbTkhjXELTQGM/Rb2eMfnDUR64BqUsqIgGCf2?=
 =?us-ascii?Q?X+2QjAG9kHHKwD5GW3omft7jYiqeKmCNco/5J7htOlDgkFJAcbqjFmNv5Gm3?=
 =?us-ascii?Q?QXMgiDk0ysndYDJB/fupCqClRV+1S4/zg9iwRLTB/cfr3deN9ar9hG8k457A?=
 =?us-ascii?Q?DOopkHYx9RE0NVmzcNPI3vzh2NxQ0kunMr1ZHV1DlOmkLVcjSoqwSTAPKV1t?=
 =?us-ascii?Q?jqnAXu6Wgp683AGd/Ooq3qfwxOEmU7/zz0PQaX85QhAco4axA9E8bjiAk+Ls?=
 =?us-ascii?Q?WOD8emj6+VWrCp+LAEsUxUCJAuhu5ggXZGi9KUuyXE27dkJK2fps/aqyqW9J?=
 =?us-ascii?Q?Cb8BrmhA/+4zJqh2X5Opi3LFXUehq0AMxb6kqgKzXj4UMNA6xmeZt6xSl0VJ?=
 =?us-ascii?Q?EQp5DAgg8G7jnC4HdNKljCakj/1wmCZZH7hmgZxLqGXeFnJVfsMOmUEDwm7u?=
 =?us-ascii?Q?8p7Svw5r3VkPDyWCAB+4EY+C7BDwjz5lZXmZJ6W/7hKKpjh860xKZT0Auy3o?=
 =?us-ascii?Q?uui8d0BEyjmDf6A0f6Z8OKz8hip/Ewn40umBH0KySEm4IWgZzSmDIrZ15IU3?=
 =?us-ascii?Q?S5OMjl/KzpMDPARvN1M1A7Y+kAmhKuqSaJneb1tKtrpGmeiqySFwMcLc+mCl?=
 =?us-ascii?Q?uRNn89Xhbi/pVMeBoCGYclXIgjQkJB8BevjnYHSLtcF+vWhiYHx91L1SgznF?=
 =?us-ascii?Q?nFud3ZNyWmbC61Bq2bkjvHGtOZhlenZfIEwUMkrJe3JUc1vMrl0T78pF9+H1?=
 =?us-ascii?Q?oBaih8lDrW6hj/pUth57AGPpkntZtudR3VKdbyPOfQFI6SDrJLzt86KMmJav?=
 =?us-ascii?Q?k000RXjhSqQ5vNsNXDzKXWggcX0ZZa58GkSTHyJkR0+EXsJ53uLn/EAeGcdP?=
 =?us-ascii?Q?aV0lx7MRi+SAOvos1iAs8VJUDNPxyfV5D7c9qOuXyV7kce9og7BxUu5qMY5T?=
 =?us-ascii?Q?806qhxHE1FNlZ/0KReBKH5JQYLNx61cjaNkZXfXKTzqBSS3ZhHWybIl/nNGi?=
 =?us-ascii?Q?FV8N2Dg9J94eOslPmvDVXO3vyzuri2IjpcyCtdmMcXj91J5mp0o+Hr2MBs+F?=
 =?us-ascii?Q?9UxzbOFq39l9IhZ8ZyQxCDgGS03qPbhWJ0z7bjUJUdTe+ld5jzKLtaDKu/Y7?=
 =?us-ascii?Q?yMhN7cBnARkN3JaXhLuaMLynowoX81J7tBL1JBXjUsWeFP5KmnujNY5+lx3+?=
 =?us-ascii?Q?5gHVN/oCEy+gbtF0IAm1XyPu6ff1d7iA29h81Bwe?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8DEE30D5895C044AEC61F33F262535C@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a482d8e5-3328-4e2e-ca66-08da603f587d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 17:37:20.9878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anqaa9NbLem/Hx6PM+fd5KliRhAqtedJFGBdXG/Lr9FE2ZNk0/xdrF27JDTfpB1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3626
X-Proofpoint-ORIG-GUID: bBMCcBTbcXG5Cnv_oI8zu-g2iOFZHnY4
X-Proofpoint-GUID: bBMCcBTbcXG5Cnv_oI8zu-g2iOFZHnY4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_13,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 04:52:32PM -0000, tip-bot2 for Jonathan McDowell wrote:
> The following commit has been merged into the x86/boot branch of tip:

Just to clarify there's not some confusion going on; this is already in
-next via tip/master via tip/x86/kdump.

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/kdump&id=b69a2afd5afce9bf6d56e349d6ab592c916e20f2

> Commit-ID:     2faaa8f3ef16d794ecb28f9a7d9dca25cff98bb3
> Gitweb:        https://git.kernel.org/tip/2faaa8f3ef16d794ecb28f9a7d9dca25cff98bb3
> Author:        Jonathan McDowell <noodles@fb.com>
> AuthorDate:    Thu, 30 Jun 2022 08:36:12 
> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
> CommitterDate: Wed, 06 Jul 2022 15:45:55 -07:00
> 
> x86/kexec: Carry forward IMA measurement log on kexec
> 
> On kexec file load, the Integrity Measurement Architecture (IMA)
> subsystem may verify the IMA signature of the kernel and initramfs, and
> measure it. The command line parameters passed to the kernel in the
> kexec call may also be measured by IMA.
> 
> A remote attestation service can verify a TPM quote based on the TPM
> event log, the IMA measurement list and the TPM PCR data. This can
> be achieved only if the IMA measurement log is carried over from the
> current kernel to the next kernel across the kexec call.
> 
> PowerPC and ARM64 both achieve this using device tree with a
> "linux,ima-kexec-buffer" node. x86 platforms generally don't make use of
> device tree, so use the setup_data mechanism to pass the IMA buffer to
> the new kernel.
> 
> (Mimi, Baoquan, I haven't included your reviewed-bys because this has
>  changed the section annotations to __init and Boris reasonably enough
>  wants to make sure IMA folk are happy before taking this update.)
> 
> Signed-off-by: Jonathan McDowell <noodles@fb.com>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com> # IMA function
> Reviewed-by: Baoquan He <bhe@redhat.com>
> Link: https://lore.kernel.org/r/YmKyvlF3my1yWTvK@noodles-fedora-PC23Y6EG
> Link: https://lkml.kernel.org/r/Yr1geLyslnjKck86@noodles-fedora.dhcp.thefacebook.com
