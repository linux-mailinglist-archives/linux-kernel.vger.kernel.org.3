Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C215A47DE34
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 05:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbhLWEKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 23:10:54 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:25111 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238670AbhLWEKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 23:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640232651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NsMUhOJ/A50PHNUUY0eWTcNXPSVZRY8gKR7yuTzIePQ=;
        b=ijzzotRP6KDKhcH/bRj5Aq5wdlEunwC6fJGmdis3Zistz3gLSuqInxEkmFvp/JdpyLSBBa
        YPK25ISQe0apL3IMmEPK2kgpeJbFPf/72uHDni/JVGNuvjsFz1lavmRMW5KGFtg/vk5r6t
        7uLDzSZm4bwIyB57HWoYXwJl64pYC/w=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-aW4lXDK2N-Oqiu3TM2n69w-1; Thu, 23 Dec 2021 05:10:50 +0100
X-MC-Unique: aW4lXDK2N-Oqiu3TM2n69w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwd8KLTlLEKJhWkpU53myJ/z4Pf9hCzE7CrofkJU11gryYN7VxiuQlHhE4mN0iCfCXI0JwgW9OxYexGE1fb0uew0FUQn4IQEb/pQ8GGPiZ5Op1rvd+QcfEMhf9UT0Aj3NpxAqfKnp15OafB3EklsGw3mBwrdpt8vK6mty8FZRYES39OQsx9o7aaxS+QaXDkBrhoWq9kLdOksgoSfARGMdY7r+lorb8KMnym+HPt4XJkoE91zlV1oAP5NSIhzvL2eK+tX1DvBCuyCl+PzjGM+IQ6vWVKu66wi0wNJx1tzEn0PPgUP6UV0ZT6skYMwVL37j2q50jJmf7mKqacPhsGDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsMUhOJ/A50PHNUUY0eWTcNXPSVZRY8gKR7yuTzIePQ=;
 b=Jdgd4nM5hzKm32P7bruM7csGetV1C2UAoyXQTGmdQCUMC2wnv50JyIzym8gOncnvQh/OjMS+KRBd8mv6EXFrR15kNQ2OKdN50KN41o73do7Rkj6AzBCih0L1j8gyKB6BmVpqwTx4HFyRMV/qqvkO1BmuUvDbi8Yg6cIFlhhz1/jmu1ICf8QHOjlYWIBdBrx3uN+vXX0T8xarSMWJdnEL+z28uwvxWd9iDDmGU5AKbpj+GaQuVX4jjMSXKyopHHXlY/mtxlk9FsgpcGHAycTuySRxVnDOaa5x9DjrS/D5TVoRys6hlk8oqkzLbWw6dRPZbLqn5q91LkjwyPmi5e/Zlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12)
 by VI1PR04MB4576.eurprd04.prod.outlook.com (2603:10a6:803:74::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Thu, 23 Dec
 2021 04:10:49 +0000
Received: from VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891]) by VI1PR04MB7102.eurprd04.prod.outlook.com
 ([fe80::ed2c:83e2:fbe4:c891%9]) with mapi id 15.20.4823.019; Thu, 23 Dec 2021
 04:10:49 +0000
Date:   Thu, 23 Dec 2021 12:10:14 +0800
From:   joeyli <jlee@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        James Morris <jmorris@namei.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] integrity: Do not load MOK and MOKx when secure boot be
 disabled
Message-ID: <20211223041014.GB1178@linux-l9pv.suse>
References: <20211218020905.7187-1-jlee@suse.com>
 <9b93e099fc6ee2a56d70ed338cd79f2c1ddcffa5.camel@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b93e099fc6ee2a56d70ed338cd79f2c1ddcffa5.camel@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-ClientProxiedBy: AM6P192CA0070.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:82::47) To VI1PR04MB7102.eurprd04.prod.outlook.com
 (2603:10a6:800:124::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed416c3b-ed91-4fbe-040e-08d9c5ca338d
X-MS-TrafficTypeDiagnostic: VI1PR04MB4576:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB457611F10DC8E299EDEEC406A37E9@VI1PR04MB4576.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PTG0fi4M4Jy7nMNcqu0rRchl4ZeKIs6F04Xkj2b2TcGZXs0rVhqGmOkgVcCw4TLk8QdxjhLBIocLwJpmNMEkW1QkgfELxTihOVlJ+GqACzrNIADdsPUrsovNJHNV/SQ1oAOgOXKFGPatlDkoinUuIvDSkNUArz/MfAedwhlV/ZX4RQmqJ6VQjriJp9MZVbBlllljT4Vg5HXbAnY2DuAZisT3t02PQtnh0Xqw8g+HdKSheMK1zCe6z3WtDVLsYG0pTKyzIqzcapwr9jA2Wk0DtL8rljRQKMCk4504tCV/zmtSVlbwCZASOeo1SHImrz3cerBx0DRukKmUMmbPZ8gsB0qyXMtlUSMBolBDvH4MnJcPEo3gR7uqkvIbRHMObqvXcnwqZNdvqf7j0EYnVlvB+L61Q9VeSEFCNnBfkEFPHxMTQ+2491R1wC46lre/c8V2UjPxYTrkhwoMObYTPvUiUUyl6KKQlnlf8phuuDyhtMdZD78IzgOzbIHzbk+89/bAclSMamNtxcNT0pxvimqEtVo9D0GXVxZ6f2GsG3TJft6olO/l4B6YBwqeOcmiZmm0sRqLMUhKgT0x11lNpl+2Ugcg0BSbE3d5WckI8HVLUA2GQF4dgzPrRDCcAjnbZTVHIwjkzZlm5IzmUNhDolDRnAXHHvaxbjZx0d3QY5qlXyNAiAZmxasGrp/mYB3XecdO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7102.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(33656002)(9686003)(54906003)(6512007)(66556008)(66476007)(83380400001)(6666004)(2906002)(6506007)(1076003)(508600001)(4001150100001)(8936002)(66946007)(5660300002)(26005)(6916009)(8676002)(186003)(38100700002)(4326008)(316002)(86362001)(4744005)(36756003)(43062005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3MX95mhp/5zIa5W2U2NiZ5HUvnrUCOZAWqEpKzctQts5QQCQqaLD91Q4ZrMm?=
 =?us-ascii?Q?u1FKPAzVbS1h4stV3zaHC39YVrai55kJDGeHGDWkPRsw3nvbBh3gxGC9xbqz?=
 =?us-ascii?Q?pJ6nyzZ2N3q2XbD2V5Ls1c+alNJeurBeBg2nh078NzuRSdTZuGCllyJ56Iwk?=
 =?us-ascii?Q?k3Iq1X/R3yx7xgKs+jGhgMxtbeOzzgBQSNS1t6NiPRCZdbyEGhvm+kI4eE4d?=
 =?us-ascii?Q?jC3EswDS33GW8RnRx2cwZZtFZG8iCkfV8fwXdtJIyd/jUefE56zfVCRI3kDa?=
 =?us-ascii?Q?mpmqxDJsxsILS0CzL21ZE09DSZhuCMV2vNBu+WzNLO14cjRpL5iD6Zx+cnxJ?=
 =?us-ascii?Q?a6FQlWC2dP3+UoS0GZRpQci6K79z8v/5xkMQtpQd8BQsNSae9pHoBO0OtaDW?=
 =?us-ascii?Q?hvrIOvwKwHSg2jBN2+FNFre4xfQe5ub5HUYJFMJzkMnH3URRI6jOmXC3KjlZ?=
 =?us-ascii?Q?VHwBXZXfARjC6vZshMJA0Z5ZY0CsMRzeA8mB85KRdRryKy5qasTGEOwEGNMK?=
 =?us-ascii?Q?LEuUPEBAdXqiv+FXi8mKLlO/h6dSkV3oVT/sC97M3yAm5njPZ+lLgHTUtbGf?=
 =?us-ascii?Q?qj6ZKUSqfPcEuHSUOi44x0UuynzxvGBSddDDeTuZwFazraFt918vTS8I3Izc?=
 =?us-ascii?Q?xvla0/WzXWOkHjIEwp4Zf0VGPLYDr/3sutH/Zhihwg3RotsK4N/jo7hzafab?=
 =?us-ascii?Q?kneScVSvAY6qnP6nmdG15MxlY5Ts2caqgl05d5S//m+nmgygW0z6q2z3dWWp?=
 =?us-ascii?Q?pZRQ8HJBCnjtHG3alEsadY+arXtbe9bxZSywi2ojxFJj3c8/NMwFgE+ShT/+?=
 =?us-ascii?Q?qJHA4rEcKHb2R0kti9b4nmG0Gio3yt2iMZDFDQPe59pglKsMv7IePrMPV4O8?=
 =?us-ascii?Q?QTjOoTtwxkcEKBW8WVv3RX7LRGisP0QRNLqys9prgmV6zj0G9E4vSQfDu56r?=
 =?us-ascii?Q?R5l9PyA0FMqlK4k6wcjzyPruHhn+tj1FntM7kjdJN5oiLW2dL+k9eyLl7ihC?=
 =?us-ascii?Q?FacIH7nTnwjv9A+CLCMWmcH+LoLUiPUfJ2kwuFvTeOdWfGVho98edMhMkIl6?=
 =?us-ascii?Q?rombtmB84J3x/yo35jlPk+yuEl73UF0rCe2KqS4zdKhSBeqiDacp9Q9a8Fgb?=
 =?us-ascii?Q?ezEBZFkgAHRPdRspVG7Aqfd2ubVg6GQ3jYr0wPmmwMrFCWTJ5ZDNM79+uNCu?=
 =?us-ascii?Q?bh4zGlAGzeHcaOAfv4fyemJjYzylpypDDlGuB1vCEbv6ToLnfKWTEL/IHvWc?=
 =?us-ascii?Q?JwcAGW39IiElHrrsOpCVwWLgED1eRtX2UYIepDPpaEOoX+EwXYI68xkDFgI5?=
 =?us-ascii?Q?wuatIk9DPR3yq4RCgsZAeG5Pt/WwAdsddnKX9RbjPAbQvd7XW3Bib/dwlv+F?=
 =?us-ascii?Q?l0QZiTo9dgrJnWp+5gj8n3yArr1Uu9mNA0d7LlX4RMQWg+7N/Gybtj6KnGDQ?=
 =?us-ascii?Q?fMgKVfJNSCa3K/lBPjrZiVtnQlxqi8YOss6fCGqtVRWwLb/zbO4Fx4wxpV9F?=
 =?us-ascii?Q?8i7ru5AK6437W/4+hkTGgHLCCVNsx7zTM3+bQllLSVYhVf2XTdOD02qFpcx5?=
 =?us-ascii?Q?J1oncFNjWGLZcseZjdM=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed416c3b-ed91-4fbe-040e-08d9c5ca338d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7102.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 04:10:49.0900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZaKwM4ZXPq3OuJiGS0WqFep2ikqSH2j0eJ5fdFyRsvN22FHupeHEE8hKskch+yXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4576
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

On Tue, Dec 21, 2021 at 06:28:31PM -0500, Mimi Zohar wrote:
> On Sat, 2021-12-18 at 10:09 +0800, Lee, Chun-Yi wrote:
> > The security of Machine Owner Key (MOK) relies on secure boot. When
> > secure boot is disabled, EFI firmware will not verify binary code. Then
> > arbitrary efi binary code can modify MOK when rebooting.
> > 
> > This patch prevents MOK/MOKx be loaded when secure boot be disabled.
> > 
> > Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
> 
> Thanks, Joey!
> 
> This patch is now queued in the next-integrity-testing branch waiting
> further review/tags.
> 
> Mimi

Thanks for your review!
Joey Lee

