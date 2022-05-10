Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38E5521455
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 13:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbiEJL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbiEJL6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 07:58:18 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04802B4CB3;
        Tue, 10 May 2022 04:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYOV7wFQGBnD3bWUGH9zLFvWVDysLcqZWoxFTJElimyqfM/Y+BS6k0cdsBGcDbphiPYFQC8Rz0srz7MZnTRWPfE1ARrYTwXLxnPlZzUJZ8fLPMU8aHPFcZI/++5tD0h/XVS/qsiE8eKmSYDyc5CDk5TQbga5RQ79GrWY/mFwXhaloFWu5TGPV6xofZnl9ngvO0VgS9TSJf0mwOMD4IrUBIhVfgAMDj0faxOe8h/d8l4BB0+FSPjR0n8dyPDHsKgB0DKP9ZuMPiegYqe4N3bRoAB3fbC/bIzRs0SrFkmSTK/e83TAzdt0IDorMs0IYZXPfnQB3evEyC8DbB5IpI/fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq770z32r/JceFY6MwmMcz7CISthKzYMn1kzTu/uRWM=;
 b=iEu5kpTYhj3+GWxgYcSnzjzxcRvAFLKs6IPA5chm+yk+WdzwAwga7a/YfPJfaOdFEhO8Jb8xnEdBl0fOZwx1VcaQPcCo3B7fscWVdnlsX3mN91MaGpRoe5IM/Jpf5rcgSI9GxNJp2h6r1mfzBkBZBf258AS/ehlxJrK/nzDRPbQqUOvNEiO+xmk/YiUJ7MzHNZke5Uv4qM98xNj76SXj48UrZvQKO2rSyuop7BcwXe6WqyAV3rz4F2Me27OA0b3b0Umki8ZbNZu4cTB++qMzTgNnF1qseQAHPBg9JxzfrQauwD0N5kSiAD5RXQLt2FeWnT+z2RjNYQM8ndk6q9cfbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq770z32r/JceFY6MwmMcz7CISthKzYMn1kzTu/uRWM=;
 b=DQrLqAgB3HWTf4aKEfbCMp10mkPQeC1V2l6YJhzX4w+0NxhPrv6BiYwEm3cWlVur/vqzNU/Tirms1+9aTXozuPJVaTIID6xHpKPWtZxk6Tb1k/nGrodWpbGQO8DVQTkCbR0nL9twC5lH19aUyGGD9e7GD1YnZ3HgdfnX6UzZjB8=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by DM6PR02MB4091.namprd02.prod.outlook.com (2603:10b6:5:9f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Tue, 10 May
 2022 11:54:18 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a525:6e3a:42d5:255b]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a525:6e3a:42d5:255b%3]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 11:54:18 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        git <git@xilinx.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
Thread-Topic: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
Thread-Index: AQHYW6EniRNoeYDgn0mpsS0KuT5WS60Qy84AgAdGJJA=
Date:   Tue, 10 May 2022 11:54:18 +0000
Message-ID: <DM6PR02MB66358D099E0A1CA30D3B0C57AAC99@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
 <YnQ4Ngu8xt7DBi5C@kroah.com>
In-Reply-To: <YnQ4Ngu8xt7DBi5C@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19d78660-1f7e-489c-d1e2-08da327bd02b
x-ms-traffictypediagnostic: DM6PR02MB4091:EE_
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <DM6PR02MB40915805CFA7F6E8CC89532AAAC99@DM6PR02MB4091.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5wRJOsSL0J2Qp7erdIVBeXWo5A2qcahOts2JgDeyKA/zsyG00PKWIG3LPwkvCT32xwhEsdgyleJ4HVRWnx6EFX9Dr6LGxY9K1tC7J+tnXgYKRCdSLln9b+cshd5iY/FRp/pms2dA+9rvZACX8iAR/acgxkJBaj3NipaE9ArrC7Y1rYJO5Eca8oAGjPg90bz0YnLbGBlTbl/zpdY7ALGt0s7JPval5TmYqY4jIfPQq6tqRFmZTImTL8UhH1ONihqt8lG+tJiW1bCcH2ILAmhXtdLO+OqFpL+YESQOsjto5IRzcCyDAo/a08VS2cBwaADiIYhnHSSNXyAECLciroKTyasJYQkytBmecq/LpRDaY4SXNPwop/q74aaw6fhbs++gH60j6PPomoOaTHRuyVw7EJ69oYjW2jvDjdk38W+uL+YMfoO6zdNfp3V70fKXP2jo9v8K1TrvJEl+ZofcBy3SxmNqaMydzr36Aqv+kYTv60LZ0VYsMSvRJ7MLQ+0ami7gVCmqZojWD775TkJ9lWC97+18StHoI10Bzf7gjhifmrfaeyG6hZa3xVx0gvQ/0Ul7kCm7CYjqhLaVJiinYuMIZ/0+lot+aKx+zwEtQZXAs4uKuTmbB+ZHLAUvHFxLvwjnV+yNjhuEDS1W1CvP7faQfAz0sZRKhXj18AXAMuqe75VulLugYMNULfsWDW8A6iXmkAO8up6Jjbb1JFlUx6hY4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(86362001)(122000001)(83380400001)(55016003)(38100700002)(38070700005)(71200400001)(9686003)(26005)(8676002)(76116006)(7696005)(4326008)(66556008)(64756008)(66476007)(66446008)(66946007)(186003)(6506007)(8936002)(508600001)(53546011)(5660300002)(316002)(54906003)(6916009)(52536014)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HHrkU4NbxuYZQJzbNlOxzdwsPhMzYOG44V0BCCbbcoEthOZgrJBUuP69rob5?=
 =?us-ascii?Q?8TiCKKnko1zSBB0T33VRYLN4K2Dp1LcNmtvJz/41DnsBmCsw4XVPlaSW7UaV?=
 =?us-ascii?Q?bqzz9cgXkiiTpHZj2zolUFT8ZHlM8QuA15Zkz0mbwcxDkS64JdvMyhsMTUM4?=
 =?us-ascii?Q?etLjbKIBLIp7St2Mwd8fgFJBa4yUlqBJQ5TM8sgoHPIKBThcYogqVxbg9G6T?=
 =?us-ascii?Q?6BU6fG9qpgyIWVxDxuTsoacwkKFIVzjVgyX2ooHNlE2P2HW1zmCtKBci6/LW?=
 =?us-ascii?Q?i+V4oa+x5QpsBTquD4Ys9ZlOfs/RxZuyIMVaN32NH+7pW0S4L6CsJqDR3ZND?=
 =?us-ascii?Q?q11yRxYT1NFFxWCF25EupQpL6zXWDkGNSIWJIGTY9s+1oh+Rd9ssd/F9caZ0?=
 =?us-ascii?Q?mqpxfsVtdglpUv7kLBxIQs1yvPlkQwYoofMbS9ZziM86weO686tblb9KvoQE?=
 =?us-ascii?Q?u8EW/ix0HlIa2PdreZ6czh7nepR4GNQnGj0sp4bhcmiUd0eha6cYETR8vX8i?=
 =?us-ascii?Q?IzmSevb0357gS8NDR3BHPPSjDDX5QmUxSMf7wlAAFmjXPlaja5CRotvHOYgV?=
 =?us-ascii?Q?XXHkbtFFxQr5pL7MYrod1C9lv/HV1IEYKNTLiKzd23iXBQB+IIL1IIOlTt37?=
 =?us-ascii?Q?uQ+2eqywu3URnHa9qW8PNYXBU17OyyXmZXAV+JOmI05H/CClsMVZdzCbotcr?=
 =?us-ascii?Q?nfSfIa2oyzVdL5OithHHJvkwzbysBGwgnl3DS6FOvGheMZxrzLr79drbcAtC?=
 =?us-ascii?Q?TJhhGTjsquYtxL0r/rHhIm8SX79vTUXmtD9go1dwNHyY6GVJy0NpddNHudqg?=
 =?us-ascii?Q?PxzzjQX2/BQBmoxd1u8898Shzo7u87gJCVjAaXKe5rnzhaHdQuInCBcKormW?=
 =?us-ascii?Q?8FoL8fbbvk2UHRvq5e0Qx+ccbqKI6lkc2PFV6DFC0CF+A3L7LhHrZuRegj+G?=
 =?us-ascii?Q?/eOfZ6n5UVmbinIJo4qnTozqpjvNIz5g6WRo6jrP67jV2lLNAr1znipzRw5U?=
 =?us-ascii?Q?DWMxQ2E8uBPjO5eqGroIYm6IyLNvuPYICZsay1twvmN3QwTT3SlZqIuDkzc+?=
 =?us-ascii?Q?yqmRxHK06+/FkxoDuaS29FAo/D4HZOhO4IxuYYPuxX/GQmZ4ywEE4BQrSZE1?=
 =?us-ascii?Q?MAc2T8sZ6Rd2vLTKDVlOSh4xIlZnGZKKgtgd8vMMF6mqAP0si/qZUTPIXk2B?=
 =?us-ascii?Q?7kqM9S6aj6+II2y2Vp7PI4dMpUhZKqnqAY+SjI/VaqoG9JduQ12cb80UhGEN?=
 =?us-ascii?Q?xPuN5fIjj5fjYlvZ8DyUxTYpejSYw9SLJ7dzllRlxr1SJlPXZuqo1WZCgUN6?=
 =?us-ascii?Q?9O2habb5f9s1UU+946Ju1DL4IoBtzE7HHjkJva8iGom93CU61Ewxvd9TewtV?=
 =?us-ascii?Q?c9e+q30XMlYu+OXnLWfqWNdShSjf4QpqRrnqFGP1v9BbxfMJW5XI6soRHFno?=
 =?us-ascii?Q?K1uax0A6c7RUkfIluDvVVbRY7m9WT4n2YgVmVH+gJqzE5IU7y0KFYkvGYy6E?=
 =?us-ascii?Q?JIJi2QUm1tico/IA2TNRFfmO0dUyx3Za0YvL1satKzy8rDnXEppVAzMUilx1?=
 =?us-ascii?Q?AzskcQwcGRIlDWzg1xhZGv7hf80o8HvRJ5Dza0DmYA4qduW4UnIEzs3LduWW?=
 =?us-ascii?Q?3mAt6aVERPWbaR204iqmsPtBMEvz7ZfokE8V06/JZFgS4ZAEI+WAFHEw9t2L?=
 =?us-ascii?Q?qWFmXdCtAagww1ZYMAHpmekgk0kOOxmS6Q8lRzsXFVL55535T+CjPllXs45R?=
 =?us-ascii?Q?XpT7MWDWSg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d78660-1f7e-489c-d1e2-08da327bd02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 11:54:18.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxnLc4a/TaxQjX/0ETYP4+DDiFcarhrsgG3XkWtKxtLpTyM9j006RbvdnqDk8B97rAZ8Ej6rFV8K4RMbDQPulw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4091
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for the review.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, May 6, 2022 2:19 AM
> To: Shubhrajyoti Datta <shubhraj@xilinx.com>
> Cc: linux-serial@vger.kernel.org; Michal Simek <michals@xilinx.com>;
> jirislaby@kernel.org; git <git@xilinx.com>; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
>=20
> On Fri, Apr 29, 2022 at 01:44:15PM +0530, Shubhrajyoti Datta wrote:
> > Many of the stuff is reported by static analysis changes are
> >
> > - Update the copyright text
> > - Check the return valuesof runtime and clock enable calls
> > - Check the ignore_status in the isr
> > - Prevent writing to the fifo when controller is disabled.
> >
> > Michal Simek (1):
> >   xilinx: Update copyright text to correct format
> >
> > Shubhrajyoti Datta (6):
> >   tty: xilinx_uartps: Check the clk_enable return value
> >   tty: xilinx_uartps: Add check for runtime_get_sync calls
> >   tty: xilinx_uartps: Check clk_enable return type
> >   tty: xilinx_uartps: Make the timeout unsigned
> >   serial: uartps: Fix the ignore_status
> >   serial: uartps: Prevent writes when the controller is disabled
>=20
> Nit, why is the subject line prefix not unified here?  Shouldn't they all=
 be "tty:
> xilinx_uartps:" like 4 of them are?
>=20
> Can you fix up and resend?

I will fix up and resend in v2
>=20
> thanks,
>=20
> greg k-h
