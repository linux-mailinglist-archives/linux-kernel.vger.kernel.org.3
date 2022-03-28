Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65C34E9264
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiC1KSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbiC1KSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:18:00 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E62E0D9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1648462577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCMaSwR/kLL8bKO/tv5FABl25nbgDbfuINb/RmGWKSo=;
        b=O09HrxEXvt5++3hVJ/sWHsKKx89R/ai0X/Q5nD+qy6qMilJ/3QHl1tfmrQt0nEVmvHkURi
        gKzNaYzpMu2kQ0pVaFHUUosLehpRcuTDrgBhMkAc/NBgZQ7OlbZQzP3MeJcPIwv1UqJF/7
        OEthd1e1qaCqgy7aP0xEKIKxdWKGygw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-28-fPmwJcD2Of-RmQ6AOXvAIg-1; Mon, 28 Mar 2022 12:16:15 +0200
X-MC-Unique: fPmwJcD2Of-RmQ6AOXvAIg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjY552vtO4fH/FkhCT0uN0TpZ6YpS81XYCpZUYsQfb6vM/bV0dtd4KYAdCG2luglqk2VL4R/fbyjUpOqDQBIo7F7dUWSO7Dei1nI6K5svTxEj02IqoZbZES1ap0qKrJ3QNc8T3S/fwRxm+eunu1y2vG7vxd5SMkmpTwg1LMJfzCKVLucH9cCA/7JPZXVuDJ+f5TR+F41Vnvbys1CsAIUGQKZbyyMMJ45XjRkCKdCAqkFq+yuhq2GFqBXXF7wj/aFeV7JD+W/MKrFAXJEzRkHvqDHj4QPT6SfnR5Zul85dLfuM35dMIUXH+n0XqXW0zrznUJpbebNtulV8LV91Dw+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CALA0ri3pm7jIJZVhMZLZGAEKnpRxZRZ105Z13Rp3bQ=;
 b=D6deS+0gHVMa6q24EHXoTtn8VsOhJABKpmOOBajUUj3NHZOBjuwyipo0WvZOF4EVKjIgPPWPsAJsOU9wykIdXl14wxJZ9xQLOVYiyqVRNRynryYtXZPbICI9+o7hkUwVrDTJ5GaFw7GJ0322nAF1TeFVbFivEsiZidFJAPmaliLh/rSFkRttmMvVbJ2FDNiyJ7U3h+1cyG6OYQqBzqN+WhC574i9KIhhot1xzgYyWoMxkYIEgYE9rCKZXExua1cGdqFNCTEOmFDmqQbPaCfxJf93/0C1xioMXikDeQUCrTpIr0bG51OQXluxeAFg1V5KuxEUiZ1dy4cVbwIv7m2ymw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 10:16:13 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::d4af:cc25:cf77:6a3f]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::d4af:cc25:cf77:6a3f%3]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 10:16:13 +0000
Date:   Mon, 28 Mar 2022 18:15:57 +0800
From:   joeyli <jlee@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Philipp Rudo <prudo@redhat.com>, Baoquan He <bhe@redhat.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        Kairui Song <kasong@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-modules@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        stable@kernel.org, Eric Snowberg <eric.snowberg@oracle.com>,
        Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH 4/4] module, KEYS: Make use of platform keyring for
 signature verification
Message-ID: <20220328101557.GA11641@linux-l9pv.suse>
References: <cover.1644953683.git.msuchanek@suse.de>
 <840433bc93a58d6dfc4d96c34c0c3b158a0e669d.1644953683.git.msuchanek@suse.de>
 <3e39412657a4b0839bcf38544d591959e89877b8.camel@linux.ibm.com>
 <20220215204730.GQ3113@kunlun.suse.cz>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220215204730.GQ3113@kunlun.suse.cz>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b53327-9c3f-4197-7d11-08da10a3fc3b
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB50056205E4243AF8D753C021A31D9@VI1PR04MB5005.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P/DLRfyPK5w3h7G7CVZiMfJq5K4my/pW0zlXhXIOinClJyednI9J/AXDPG8X869/2uS8Ii/h6Oi5LfQWtzltvcDUT1hKl9doK1WbRCnHxxueXM0TOomQTvAUuQEEDgIgEcYTVtOZsVzR4RsA1hTwUa+3elNni0VABPXRFe2bb3Wa5/f2NH5d8HpjVzezurnqHEeuzEa5Y4j26sDlkF1n0rpUTVNDtwcrLhmjJismjqFZ4AYuS4x5OovzVfXlwKPRsOOOXWMJGGUze8kCbzVuSK66Ze+Z9D62s2UBHQ0zIyKczcMx+yRjOdmgKvzXaoftw8XTEpyYex6rg8zwV9s3TPNAgeCimEIeKwlqhSJScks20TDeUUHAVHoP2jrhjP/IKMRaddIrJWTtTG915w7hp8L3M16v0ZHO8OkxiAuvNL07jgdoJpIGX+jF6BjnyTJ5QDyH0Dh7d3uUxiR0Kn/pb22+fS/PoZLNaM+rVn0nR0cdbhob6ecegdWzvsM+ic48hwQc9P1374WpSbjLsTFYZPvn1IAya8Y9ye4/16hG2PWfgJlvSNu+e7VySuoJv8C+FcnJRiR8tKwLDpjCIAQxClGkVpj56Mawq5t34UdQvIMYJrpczmlg8WQOJzbYIu4Y/GMu998iYVIduvotTvPOvfLIChq5JNZDYXl9neOmSeFk781PXQwzCU3CQysnGnyApnfLiDwgf1EHvn7l6gMZVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7416002)(38100700002)(5660300002)(54906003)(8936002)(6486002)(6506007)(33656002)(15650500001)(36756003)(9686003)(316002)(508600001)(6916009)(2906002)(66574015)(6512007)(86362001)(4326008)(8676002)(83380400001)(6666004)(1076003)(66556008)(26005)(66476007)(45080400002)(186003)(66946007)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WeleWIUl8eLdcOrFmM3sL4VmhHWdLTL6KC83IgEX8FXCkr7rrkKNG6vhqgqI?=
 =?us-ascii?Q?LichmlU1TvjZsUKFwlPCl7aFNO0qJGUdiEgNmylC34xavyHdYbOhm6ut/F28?=
 =?us-ascii?Q?aE4Cp9ejC18OPiASuabC4yipoAWi4x5/GfDcQ5qwIHXCC25GJASVu5i1pniE?=
 =?us-ascii?Q?CJdpfr4vseMoO0eKxeYIapa7jiKY+7rjNhSjf9IBm0iOi1vAvprnrd6zmd7O?=
 =?us-ascii?Q?dGV/vxErERIc87lKrfjTD/iF9Ejid6NoTsNgfKb7BmbWCfUGzcKToVnIZG2h?=
 =?us-ascii?Q?MRyHjRxy4ckOeTRwEBeB/yKseinMwZ4uD2pqGUG8rP0sMUMjnBfNAzyZZp1C?=
 =?us-ascii?Q?JRR08o5t9FPGSsPh2BqrjPjdYQON0QWZvevPOwkSwRN0NTvQv/XVvorghcFH?=
 =?us-ascii?Q?Douk9pDU5RQpLHDz0RoUA4Q+5Kyx3wbADEV9ZF44fc1tmPpaX+I7sDdNqTPE?=
 =?us-ascii?Q?TGBM/EzyiRinN2reHo/PpLFAKHTv5UIMEWapYr8EqUpTgr7XW4CutPTicp5l?=
 =?us-ascii?Q?+ie/YUEs6yY2ZZc89F1pBXfRN0BnxkCeKbvULuS34fdv1eqa1H/i0aztrLRE?=
 =?us-ascii?Q?umBFA94LQYoT1lFfYBhKBfVIChatoHZCAn+oocDJuFieKajiVqETzwWWXkG2?=
 =?us-ascii?Q?RrXdZHluKUZx5/G8Mn2jzykrHYQFj9XegSNtWVjGJBKZ9ZQAor8mfutKNl27?=
 =?us-ascii?Q?qIqUKAa8gufRTZNoeReSn1Vaq2n52WrKUt8/Nl2ab4T31TX0RWRT3wESLiSh?=
 =?us-ascii?Q?VKMACPhgRrGiNfA7jswCFk77ktKTmNuvI/QPAnHsj4zz36Ug0O6BKk37X13M?=
 =?us-ascii?Q?fPdtLgBHA7Sk9H94JRV3+AJEd9sfZd8c0HrnVcyiKBKIBSNppTJ7dS6rFOr6?=
 =?us-ascii?Q?giszHvyp3IMt056fajDhNccvdOwFmhGZJESS0PXQ9vLWotOldEaUirt7MMJo?=
 =?us-ascii?Q?wJTusYdLmOpC7QGYT5I6jfrXHO8V1FvFi+lpu0Myu8LW+9vhVRTUSd6t5tkA?=
 =?us-ascii?Q?Nd5Zxlowv2o/OkCiEv7PL3Rl4Bnrv3t/NgVtUfbtgj7V66cOTYRsBX3aTnjy?=
 =?us-ascii?Q?AGc3akORQKRt6JF5o9u8VecjcnPaCRnOj69q47itdIFXHOoX+wHc1iKe7GXR?=
 =?us-ascii?Q?kq6iFlNCTNY7WMK7wEWKulxLReB1uVAXHyIzxB8NEiQeiNR9dUFdwguNfkxx?=
 =?us-ascii?Q?p9Jo3vZCxVovnsxvii8UmozTUQwykvIBGdyNWlMcFMzNd4X63YJIgJMcsCrQ?=
 =?us-ascii?Q?sRPzu8zi7Iox6iUt5xJn10K73UwwAuUsfqLrpmrTzUeuE9him89g/81+4OF9?=
 =?us-ascii?Q?kuv+RPosRgqWmSqWDvWTO1KVPTFs3a4wM/LeURzMrHFxR8vxgxE9nOaFJi/6?=
 =?us-ascii?Q?SbzV0ak2DbVksCxWrWEjTzAzb76+iytO2MGAiC/XzYGB0S9ow5zfiGPIoz9v?=
 =?us-ascii?Q?wcc3sqpcg9vhKA/XUMDz50F2/JBhvBA3BgUKNl9L6/ob3rkoqFAcZuGyPoMS?=
 =?us-ascii?Q?WSs0Lnm3naLBJAaySIDmm94VWgcTpEu0oCeJB/wtJ3KmG8lB/s5gVELwIq9V?=
 =?us-ascii?Q?FSWrGJ6GYhEAeYeofBrVriKqqLVfdhQw5CRHOv9C5t3Jl5b1SpZzvHloqsUM?=
 =?us-ascii?Q?1fKlIs59TNSNOQrCFB/LGs7wi1bxwWPqhaFq3NE1ZIz1T0rlTwBmPA+TCsaW?=
 =?us-ascii?Q?qes0tbPlD9mS1qjxfUM6b/WrnsKT3S+86ob33s3UfN7DyxhNG2vQk+UCX88l?=
 =?us-ascii?Q?afEGDHxJcw=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b53327-9c3f-4197-7d11-08da10a3fc3b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 10:16:13.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQo/X5WfQCRUHyw9NEMJ5iaS9FCw6KFdVQfptCvbvtisuFryaTvnJXtoUe1hMVj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5005
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

Sorry for bother you for this old topic.

On Tue, Feb 15, 2022 at 09:47:30PM +0100, Michal Such=E1nek wrote:
> Hello,
>=20
> On Tue, Feb 15, 2022 at 03:08:18PM -0500, Mimi Zohar wrote:
> > [Cc'ing Eric Snowberg]
> >=20
> > Hi Michal,
> >=20
> > On Tue, 2022-02-15 at 20:39 +0100, Michal Suchanek wrote:
> > > Commit 278311e417be ("kexec, KEYS: Make use of platform keyring for s=
ignature verify")
> > > adds support for use of platform keyring in kexec verification but
> > > support for modules is missing.
> > >=20
> > > Add support for verification of modules with keys from platform keyri=
ng
> > > as well.
> >=20
> > Permission for loading the pre-OS keys onto the "platform" keyring and
> > using them is limited to verifying the kexec kernel image, nothing
> > else.
>=20
> Why is the platform keyring limited to kexec, and nothing else?
>=20
> It should either be used for everything or for nothing. You have the
> option to compile it in and then it should be used, and the option to
> not compile it in and then it cannot be used.
>=20
> There are two basic use cases:
>=20
> (1) there is a vendor key which is very hard to use so you sign
> something small and simple like shim with the vendor key, and sign your
> kernel and modules with your own key that's typically enrolled with shim
> MOK, and built into the kernel.
>=20
> (2) you import your key into the firmware, and possibly disable the
> vendor key. You can load the kernel directly without shim, and then your
> signing key is typically in the platform keyring and built into the
> kernel.
>

In the second use case, if user can enroll their own key to db either befor=
e
or after hardware shipping. And they don't need shim because they removed
Microsoft or OEM/ODM keys.  Why kernel can not provide a Kconfig option to
them for trusting db keys for verifying kernel module, or for IMA (using CA
in db)?
=20
In the above use case for distro, partner doesn't need to re-compiler distr=
o
kernel. They just need to re-sign distro kernel and modules. Which means
that the partner trusted distro. Then the partner's key in db can be used t=
o
verify kernel image and also kernel module without shim involve.

Regards
Joey Lee

