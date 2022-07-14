Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDA8574645
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiGNIB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiGNIBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:01:21 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2107.outbound.protection.outlook.com [40.107.237.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FC822522;
        Thu, 14 Jul 2022 01:01:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDUPAOKMOphxy9lsBNVGaBZf2g6nDwFWL5egkL4+qo32Ki/WjZykEmo3LP1O3klMRTMBSk2rqHwNJ6vkWw5jGgNGm76CZCRAz35BK+O9Zu/kHYb6sH0HiHqNLOGe3BYL6HmR3JeBLvrI+c3izDxDZkHw/hYfPQgLsyzPdmA4JpjpvVzxRz3IiS3dC5cpuPi+B3VTOPLPS4Vjk8B22sqvSt/zTp0xU9tXfh+ZM34F/OcH5pblx4mMUK77Nhpbdqnrt4FOFC/Spr1bjzwxB6rRSHh5V7WH/AXt6W2AL+wkts7RQdhg3QfoNjg2mHYcrMhwiCZnSLpUMYnHleQzqgDz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwwE8cisTu7u6opjMWRDzwUH3LyxGNeq3/utgdQGNHU=;
 b=MjaJf8Ri+yQs68RPtTfL6r/5fUemLxvYoKMzdF469OMa8yFj84FBGHJ9l5b4qJoc0dYIG/MwyzvOLAU80V+5ZQllxk9iiy6UrByLMaq3CsVo7KPKgQT+PLufmzW0qgFqGAWnDCoj6BF4MqgWT3epijOyIq/7NGS6CQX7KBNxXrqt86SdL5jBj2oIFcLLEbH4BAlK84Dn1g2udTExXr7yWRABMrkwQ26mpTlAKSzeBBItTg/myVv6wxmGhM6t5alU8G4tuDN0/FQuMnZfELRigoYN2gElc7iHwRjQKd7wCT2bSIYFbSJzLTa4oTnn9yitX6kjsfLXStCoGzRU45ISLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwwE8cisTu7u6opjMWRDzwUH3LyxGNeq3/utgdQGNHU=;
 b=nGRVNlx40NBUUhnKEmcDNPFzmpNUhV7toGoCedzYvmnEU9MGdNykMC61utWGjkKzy37P0QBcdFj0BOTf7jlDGJZ4UGyEoQ5Ry+hoiJnjzfTRePIzujcEjBShJsZ66wNOuHuWNb8SSPHHiAGq5NNt73PRit7dyQq0gBE/RUg/XKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by DM5PR04MB0252.namprd04.prod.outlook.com (2603:10b6:3:6f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.21; Thu, 14 Jul
 2022 08:01:17 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::f02d:f2e:cba9:223b%6]) with mapi id 15.20.5438.012; Thu, 14 Jul 2022
 08:01:17 +0000
Date:   Thu, 14 Jul 2022 16:01:12 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v18 1/2] dt-bindings: usb: Add analogix anx7411 PD binding
Message-ID: <20220714080112.GA13028@anxtwsw-Precision-3640-Tower>
References: <20220713084139.2810115-1-xji@analogixsemi.com>
 <f9e1ad3b-d6ed-7392-2fd9-ca6ff0417b16@linaro.org>
 <20220714020238.GA4276@anxtwsw-Precision-3640-Tower>
 <f3c98e31-7c68-34a6-f492-95c1b6eeb625@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3c98e31-7c68-34a6-f492-95c1b6eeb625@linaro.org>
X-ClientProxiedBy: TY2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:404:f6::18) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad38908-33ed-4933-d739-08da656f0797
X-MS-TrafficTypeDiagnostic: DM5PR04MB0252:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUsTSxVKXmMeKTomusTM08LuVfi5JodagR4ibIHtRKrd+TAI4RPppxuksb1FPh+J2i9TORO7CjJQKra/xVzX0gbTMbWc+gsVz1CxhyA0tlnuIokbr73QF0JlcsKz9AGaDm1yIfs+gGLzPwFSz6ghDVZG3fdxK6wWw5nRemjQZmwQ5KF/SF4nqqG0RNaOvptpT4PzV1nZNuBKMVuUgPGvDFc2Gfsxvf5uswhaeunqeQYT7laNky5U8Un90dmmvmK4WNv9UwRXpkjauJB+ynJrsyW2Pe7LccqXWR1AzTvoGwln3smGnzvV+g/TYEDxuahfCOVuHftK2SDSjqxJB/T54oI0URJeHW8iZC1yPI+3JlVmPcuQ3CEpq6syaxbEiHO31LeCBiQTBEbUgUwCxtWLMn5dC03pLwfCBmm9OKYdLVIEHgLFcL7xLfgTv67w1B+YGTEWOupjMJqNbtzl9hMCHGV3RAda1T0X5qrA+/R34b3cCQVNaGdKaqR/Np5tdT18eBQoOIAH1DhTb6guI1mvFJ79qxC8ra+iucKkyYg+hpRp1yCHRBmH/LULQnBC6lvGSehudZqpHhMsry/sseF8HQCVnWsfc0hWlnAd2+hg+VBFWRh5NhD49x+PFPDI+L9NKb8uTx4YSOSvhedP6fAlhRdWQ0Xazlqz565uFPGn5TZzpVcOVtp/6SRuagQgkgtKjdOHpkIr3D7mn7g8fBYSicbGrTfYnuWQwb1PvdXdbPLHBkr8AC7CGsf7WXbKhOSyTXqyE3RkLEY+iDwNBhaL0JQv9vKqtByVYje2/BluJgNQh+YyPoQLnf06RvdH1WDm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(396003)(346002)(376002)(39840400004)(136003)(366004)(38350700002)(2906002)(316002)(38100700002)(5660300002)(41300700001)(33656002)(4744005)(33716001)(1076003)(52116002)(55236004)(66556008)(8676002)(6506007)(66476007)(6666004)(86362001)(53546011)(66946007)(8936002)(26005)(6512007)(4326008)(6486002)(6916009)(478600001)(186003)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d2R4/ahctaHMaWEiGUxL/e1GLHRXJXDzjAQIKYF9eBg9FmyqU2rfRi4Ppv5J?=
 =?us-ascii?Q?M+dXwz04mJQtDqMEzcrMtKgvsMZ0qliDrJjY0pElfpplkFf8nqjkERORH7ef?=
 =?us-ascii?Q?ci7ZUnoKYKUfWk5zpxMPR1vsRPlHz0kAw3kHV6EuhuMPLBpHD6zBZejO7XwJ?=
 =?us-ascii?Q?0wPEfB1QMeKY9Mtpf312e1ReV9tk2vn61CW26EClZaoDWCw8XhW17yT8SycR?=
 =?us-ascii?Q?vrNR/HdSLrCHLXPiUJzgxUTj10QXR1H87Vh4fQQoGZl4E6GWGvhl9oz3bYdK?=
 =?us-ascii?Q?ne6NnL/y0l9XFYx/S7Qw1Vzi3xSR7Vgwl4/jRZUjEERwte5+9Sc/p2Iy9lHB?=
 =?us-ascii?Q?PmWSc+rr8OMa+hmiIIf00wJxpDWS8opefSKSxHr5tcUs4GPOchJkTx5b9VZ2?=
 =?us-ascii?Q?wYuNv4z7/Sa8/ra+9SNmEycw2xBMzUJx7Z60f3qU/mwWvgNS8Ou8nSN/vdC3?=
 =?us-ascii?Q?0AG0gXnFdABZCaKDiln0GyRnuVQxruiqFpF/SnOOHOwTpqu4D3WJX/k0xoep?=
 =?us-ascii?Q?3wYis1ydzXGfhd9tJ4Zz10dMKN9nXpA/z6DcJu2rNBDCtdsttoV2ED7h20fw?=
 =?us-ascii?Q?tRtd4Qok1SjdoRVUEQknvfSGTQoima68upSrVSTZW2uKLLWoIYdaNIJmSx4P?=
 =?us-ascii?Q?dV9Q3+4dqwFICglYHSV9JAdPeaGMpl+87QDMANk0Fr6l6V/b3T8jgjK/VKOl?=
 =?us-ascii?Q?n4H38+Qsp4dlczVz44pgfXO4El2K5dlr7RM1lozgrCIyRENAher4UubyObcA?=
 =?us-ascii?Q?Ar14LiAl+Zy2u5XH/vdGTFXWUjkk0mfusTmJVJ7ClhT7x1YT3zb8szC2R8xJ?=
 =?us-ascii?Q?1Y/ZNk8xg20eVaiy/rU7WvnCq+heCyyrFNQBvs8bAq+7YRNKnHCPi8H4nYVC?=
 =?us-ascii?Q?FktykeLnHtDMTliAa+uLV+jE2diPK3HgfcP0sWKnWvdGNAUPaizc2kSCjChu?=
 =?us-ascii?Q?FAuYDj7jnfCL6BUKMNOV+oT7dK6dXSXudeBGEo/QgbTOLbP8jRNcBlnlf2/2?=
 =?us-ascii?Q?hazb6SBEquk14IDUfl21MvbwkRA/tbbcIggd5RwqFFY3KAdw8kCGCydKQCOt?=
 =?us-ascii?Q?xc84Pcn8yD1RoYzs3clduudjQ7D3ZgBrepDJOCzG4CznbR52RoSQx+Z1E8ZU?=
 =?us-ascii?Q?Iq3wT+VcAwpLz84XgcTFQVzHEd/SUxuphF4JmEuGBLyVZWZgwAVAn0981DoX?=
 =?us-ascii?Q?lT1W9LiLNJV1zoaS5yN5fOl96T8ra4fjII9FsMtU9NLX0G7t4/dvkAKmLza6?=
 =?us-ascii?Q?NeTHAlzu4+czc2aCbOhLN48LbMruRbRad+kjSwRh+ANJ+a5UomY2fYB508bc?=
 =?us-ascii?Q?ssGo5jxOmHeA+3TNvN1sQ9/e3/qfTGjDC4c9iOPff2EJwsA80ip4Lb2nd80N?=
 =?us-ascii?Q?IKYAeOYWDbOE9r2QJEvrt0AOrps7XdBDwp9/4yX5Aloy6RQUPqxEu1W1wPIJ?=
 =?us-ascii?Q?wUTBCLilYquUYvrMAx8dwpkvrnHNy8YeG4xJRVxhFdVmio1xbmVoTb3bO7Ks?=
 =?us-ascii?Q?54Jg/AamYrniwv0e5nI2p2LEm9mrBVH1VZM37iHDBNDD+y+CB9BKaSdzRaEg?=
 =?us-ascii?Q?rosQn2LGqoHnO0wgi6PP6delwqIFi0Uy+uVQyN+z?=
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cad38908-33ed-4933-d739-08da656f0797
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6739.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 08:01:17.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6H1gKabu8LvGZeEnePaRhyuQH5J7XtjblFXfpZKnOan3TXDXMYTADPbUXRma0s6KPwwGNNfHDtg8d7sWQxrGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 08:52:09AM +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 04:02, Xin Ji wrote:
> > On Wed, Jul 13, 2022 at 11:28:16AM +0200, Krzysztof Kozlowski wrote:
> >> On 13/07/2022 10:41, Xin Ji wrote:
> >>> Add analogix PD chip anx7411 device binding
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> >>>
> >>> ---
> >>> v17 -> v18 : Change node name from "usb_typec" to "typec"
> >>
> >> Node name was anx7411, not usb_typec. What are you changing here? The label?
> > Hi Krzysztof, sorry, I'm confused by your comment, this patch followed the
> > other dts example in other yaml file and passed the dts checking by
> > command "make dt_binding_check".
> > 
> > Do you mean change the the node name "anx7411" to "typec"?
> 
> Yes, since the some revisions ago I asked to use a generic name for the
> node (generic node name).
> 
> 
> Best regards,
> Krzysztof
Hi Krzysztof, OK, I'll change it in next version.
Thanks,
Xin
