Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B864F0C84
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 22:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354189AbiDCUhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 16:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiDCUhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 16:37:03 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AD53389B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 13:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md37h7j1dCGUwh5j5MkUO58oogR4eciAJ1H5QW+fXy1bX0mbApZRqVuytMhNDaGHQ3GFCpFVWs8JInQ+Nkv1DBhk0YResqmLfOTAM3ZfC1tMVUC+ZcA/NxhfgSfYvOfZhe0Qxry83JIYtdE3CWD7XnDVsSkY32FG4gTFDzH9rFm23aflqmsQ+KUr9gMyU3Th8nK9rQQhJ1KBk8iLsIenj5WWA2/OZj4NDl4xAgNOmjY14GIb/BvIQwasEmN7kwyUr1cIFyRBMcqJ/LL26Su46iRsKBN5GITVRr2Y20Wvq4xiLC4QwCGY6rPJ3HV1jdL/P228jsL3AlVSet4lZceMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je+b8pHhcwHx1B9YGKszzL6k/p+2BLsUWw20UV8586c=;
 b=CGkrHCmIknqaZHEnekmGHeHoImtyPaSYzeXfGLy9d2fR5/4EaQQSgBlh2wW/mjGeNL0SFSs0xIbFvmh7eatd9qLiktR5eQJXFQmZNxCMm3brfvDFJ+p1sZbh2oMC6Wu1bf10z5ujk9FJ/leQiLmftqW4CHojThLK5B24ED25y8XzfhUnKZd94on81tVLos8bl2l24fazrpTG2LaaxLGiewQ2HLcGhdNzIFw20x7GUzY7jD/VnsCOEZUWKbBfbz5vBC1Bmp6BXi4rkgvmHK+bfQlgy5kctrMiLGLiMOOAri74hmTBGnaxEgWyPt3ny2U9cq9dExwo0g5rSk5HudqbVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je+b8pHhcwHx1B9YGKszzL6k/p+2BLsUWw20UV8586c=;
 b=NdAksDfzrRMSR6zLlHANrP6eS1utobCuYOBjwy/PSC6MbXxSj7yYNbQijUoJ9fl9BwHypZYOWmto0JTopIdN6E47SpiwFgsqzK0cUzbGHYqQCUgZPZrHBfiCRXckJOAd/qAN0ppSwePbakoegt4Nu5H/XtpB9k2Gy+Njg2zbkhw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from PH0PR11MB5657.namprd11.prod.outlook.com (2603:10b6:510:ee::19)
 by SN6PR11MB2798.namprd11.prod.outlook.com (2603:10b6:805:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Sun, 3 Apr
 2022 20:35:05 +0000
Received: from PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::90dd:b347:32a3:bea4]) by PH0PR11MB5657.namprd11.prod.outlook.com
 ([fe80::90dd:b347:32a3:bea4%7]) with mapi id 15.20.5123.031; Sun, 3 Apr 2022
 20:35:05 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     Jaehee Park <jhpark1013@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: wfx: change variable name to be consistent
Date:   Sun, 03 Apr 2022 22:34:59 +0200
Message-ID: <2021471.8hb0ThOEGa@pc-42>
Organization: Silicon Labs
In-Reply-To: <Ykl+ngCtuMIeF+Fw@kroah.com>
References: <20220401145350.GA45053@jaehee-ThinkPad-X1-Extreme> <Ykl+ngCtuMIeF+Fw@kroah.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-ClientProxiedBy: SA0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:806:130::33) To PH0PR11MB5657.namprd11.prod.outlook.com
 (2603:10b6:510:ee::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02fee1ba-db35-434e-060a-08da15b16f29
X-MS-TrafficTypeDiagnostic: SN6PR11MB2798:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB279815832571F27815DC1DDE93E29@SN6PR11MB2798.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZyFbxKaS93kCWz2EZWh/y93/9iP5Rn2DfYox7BdUhK/Wk6c+TwUkvkA39narbdI7Vo/JAeyegqeCkK4NMjzB/9LyxBLajd94d7EWDQScPEtc4PgdeWH7FZAjMDpLm6gaffkkoWh6HxfSxxs4Npwx70JY5EurAHCVG+PnCOkxkisCnHxAwIOFPMIkErOWbn2S9ZbNbQoQHzDtBJlmE4cdA0iLatXDprklGB/O7lBPG47CQQrUMM7pIeFygNLm5yNdWrr4p3ewYGXkmo8lOpgwxXoeD7VjQ5iOYZ2hba/XHEgIzTVg/tfXOcopp3rJJFs+mRCG8YjxjO3kwkCGmxhRNwK4SvkoFSEw3Itex9/nS+nJ5kYCx0N2mMZZzzr9oiOkFg/d6H+ScRP44kVQ2CRyS1UXRpEFANKZsPliDaXM1RpvqNWuEsYgOahYGq88LQ5MYUkBQDLhpnSWsUTW8Qi/NK9q0EMkLNm5lHpyu/1hv+L0fFPzgK6lgQiXaszvJYcNOP8o16lzyPjMVbHpfJrkG26O2Bwpvv+X9q2CcjHQttN+Bvd9/y9K3hh0YrYiON1aSjDNxhFRk4Pb1kGtVJXJ1alYym7pPpUnZa6lfebgwL+nxxwEaXyiVDj6VFV5Hx49PQ5Bker4frAJ6xzlcGDxp6lFAjsjtawvkaJRvYdV8pGFP2/FauReF3+kl/bpUiz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5657.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66574015)(186003)(8676002)(66946007)(66476007)(508600001)(4326008)(66556008)(316002)(110136005)(6486002)(8936002)(38100700002)(2906002)(9686003)(6512007)(6506007)(52116002)(83380400001)(86362001)(6666004)(5660300002)(36916002)(33716001)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8tLCYU09zAAl3JxNFh0G3H9HmqbGFgV562b7MEji6wgLlxPMubyBcMW0jT?=
 =?iso-8859-1?Q?ZH9VF1xfWnWkj/Nc6WaSe5v7x2fD0WM6szbu0wRsR5rrolZqQHipoTvf3u?=
 =?iso-8859-1?Q?HG20fAP0G7NXBwXMJdxZe3EamOkDDmBLOv6zmvUaxjDMABhERSEaoyOq+P?=
 =?iso-8859-1?Q?mYeDITbQvTCO/CeVJFol1pWQbvbTEy31Ky5RDlwPeCBzKYoGt0Wy3GejTj?=
 =?iso-8859-1?Q?oHoG8zEV1NLOwUtSTGUwQmpbAgzxZlDiZDQ34jlcUKOt6/pZxDStMZcwIV?=
 =?iso-8859-1?Q?84VR3hd4GjhGmRMOV7jrAdHSENfzRkhFyf0z4T0YeOxr5z3SMAv38BCZv/?=
 =?iso-8859-1?Q?TqHsYNHEBP3fuM+Sw83TF/cZIFyPEyu3geXMv1UZNmCFH1SCntm38RJO2/?=
 =?iso-8859-1?Q?L/D3/61Wp7QFfwb1NOlRdxRxITApg9IgAX+5VBgaJ16O1hDRwpe72NGdpu?=
 =?iso-8859-1?Q?ISngeYfkI9g/qlaWtXOTrOV2eQICp/bvWRsHJlFKCnBhGqbzisRzx2hy7U?=
 =?iso-8859-1?Q?zEvdFggJ1jbF7ABmNXPE5DGaS5b/oSmYN3KQgbOKVmfNLtNPwGx5xmv1ly?=
 =?iso-8859-1?Q?9sQ2jLnLpUy9POhfmoF3JNWQegh4BAJio/Hyf8BZsPWDIhq7GzjV+A7nYB?=
 =?iso-8859-1?Q?qQQZFU+XSrzUcR7CSVvEbn90Lm4Nu6sAbDxM9JgUr2T/V95QN8nLaNYZ9Z?=
 =?iso-8859-1?Q?F7+z+AuahGmgLUt+t3Igcab4FiDCrCkMyR6OztcKsMgZpNRvpYDHgLc4Gj?=
 =?iso-8859-1?Q?KelfN+sPNcvI0MECyiJaxoo7+RYJgnIrjZDySAUxJDjGep86/UKrgbFfV+?=
 =?iso-8859-1?Q?42GnUOnktsdzx1RxizO7ftbAUCIPoqz86q6y2SvCs5oi4p9lOojRlgfE5B?=
 =?iso-8859-1?Q?NgzOle36IfSbRzXY1swv7U2LjwD/zEzuUVBf1KkrAd7OrgITJttgfLXjJ0?=
 =?iso-8859-1?Q?atHPLkHISKcSON5aUIcamlqTQFp3xGdG2wufVG17ITsn8fB11hhqKETZ7u?=
 =?iso-8859-1?Q?M9ncnfOiTc+o4P4k4zbm9kxkes2Gap2YUSj8eQzgHNfBJj/2AJS7C+AXTy?=
 =?iso-8859-1?Q?SV3tA0tfH6kdcM1SYh7RxZkRDFeuL2vOZ7O2jskw3GQ+2gCnpv+ydGWWZp?=
 =?iso-8859-1?Q?DH2+u8DxBv//5ATaFbcA5AE2cAGVlE2Gou7mJWD39YAfvl4Dsrka1eUK4v?=
 =?iso-8859-1?Q?uEqc8pCHJl6S56fkfppQYRYA3NpsWC3h0cqdAkUTBjrwp2bxxjIYFiH1k5?=
 =?iso-8859-1?Q?9AKfmvpAxTGNpkgxbtBCMsHoO9qDxeinbnj11mzSIqOqk3ZURnXdOaR4RX?=
 =?iso-8859-1?Q?qAdVlmvctC/A2BZJzUXmzAjPXRqzmIOjIRdm2miceAU98bJLR8n2eC0/1T?=
 =?iso-8859-1?Q?QURPPy+lCWuC2kFOLd9tnEvsp6gwoHhYFVlNw3f2cY1gFyMm+cP5C8vWMA?=
 =?iso-8859-1?Q?In7+V3r34AMUKCrJKNfwhVRdg49B9OVQBsksa/UTyuLQ8f6CEoYgtdj8EV?=
 =?iso-8859-1?Q?Q/r1IuMaeZKduu56yg3ZejfJujy7gJ2RzsQl2X//34KUj8NtbzwW2Dv7TM?=
 =?iso-8859-1?Q?Lg2gdSnwQaYeD9FVSXWVw09tuZjIc3GE+sC9c8VZBD9m7bcDYMhE1FamKS?=
 =?iso-8859-1?Q?kBo56E0eswmpcRjVcVMncV7AwMDDrpL9TMxU3Mo2ZoVX4iNAh8O4xheKKe?=
 =?iso-8859-1?Q?5tqqgOlDkWmreMVMyFKo2Q0cVb+1bHP/mUnFG25SSEKOnSi0+4Sg5B28sz?=
 =?iso-8859-1?Q?82NrMGwnHYks56JXXq0UEzbfm8XRmcFTMaPZxhROQw0q9KyLHgPdm5xnnL?=
 =?iso-8859-1?Q?nQGxKQUliZxyaVL381HaOqLr/aC6DOFpo0nbf4iJw4JH+qrJJRO9dN0WrP?=
 =?iso-8859-1?Q?Rs?=
X-MS-Exchange-AntiSpam-MessageData-1: 5A66FCpHAbz1uA==
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fee1ba-db35-434e-060a-08da15b16f29
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5657.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2022 20:35:04.6731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlgWzgW5WDP9SNWwo4P0vCMIJiuMGrt49K58KMczecqGn2n9WIGW+K2tSu8iIDTGGF6ZtczLi5h91whGnMid3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2798
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 3 April 2022 13:01:50 CEST Greg Kroah-Hartman wrote:
> On Fri, Apr 01, 2022 at 10:53:50AM -0400, Jaehee Park wrote:
> > Change variable name to be consistent with the naming conventions.
> > ssidlen was changed to ssid_len and ssidie was changed to ssid_ie to be
> > consistent. This makes the variables more readable. The other ssid
> > names in the code are separated by an underscore. For example,
> > bssid_filter and num_of_ssids have the ssid separated from the rest of
> > the words with an underscore.
> >
> > Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
> > ---
> >  drivers/staging/wfx/hif_tx.c | 10 +++++-----
> >  drivers/staging/wfx/sta.c    | 20 ++++++++++----------
> >  2 files changed, 15 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.=
c
> > index ae3cc5919dcd..9c653d0e9034 100644
> > --- a/drivers/staging/wfx/hif_tx.c
> > +++ b/drivers/staging/wfx/hif_tx.c
> > @@ -280,7 +280,7 @@ int wfx_hif_stop_scan(struct wfx_vif *wvif)
> >  }
> >
> >  int wfx_hif_join(struct wfx_vif *wvif, const struct ieee80211_bss_conf=
 *conf,
> > -              struct ieee80211_channel *channel, const u8 *ssid, int s=
sidlen)
> > +              struct ieee80211_channel *channel, const u8 *ssid, int s=
sid_len)
>=20
> This is not really a "coding style" cleanup, it is up to the driver
> author how they wish to name these variables.  It is not a requirement
> to change them as the orginal names are just fine.

I have no real opinion. Let's say you can apply it:

Signed-off-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller


