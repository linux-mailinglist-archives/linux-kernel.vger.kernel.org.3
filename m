Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339124C65A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 10:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiB1JZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 04:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiB1JZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 04:25:36 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2D5673FF;
        Mon, 28 Feb 2022 01:24:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRtf35gn5BlmrGn1ch0sJvFzZl0eYIsnH+sJumAuqg4cgL15vH8/rkmhPIpU1j5C1s7AI9jFVJ1I91s1RDU4WVZaXte+doZSlHDBxxm2SetBdSaP7i3EvC5ti1J+TkWHloC2ZmjW1f8JPZT4/+ymzmngL1/6XlxyekpzS6W++tMymXGyOFhzXbVPqXBd31ATToH1XQR8v2C4Gz4j4KV6G+c8V9H3a6Y+N/3O/QZGvZBGbaJlgesBSsf6DVQ9PclvJxcVV+pUsaLh7gg3JtzMfkVSDTkymyD+r4LA5NzcoV89A9myUto8T+V1SkH1EUCFSxmFubLq7Qqrr2ROGMqteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHAZC9q8SFP/6VBpJyFqJT7+6tMP6I/iRqvhB7Ot5a0=;
 b=X9WcMqwrhv1VnVZtxNbqVZVSGVjI64U+3DCu/EqagCNrlwIgvnsKtcF+UYUJRjmCUgV3UWVNPGbShYwCcZvDXs43x7boM5+IQMM2qvUtOhDigzmLQSxV7Ms9n+tqyrKyS3aDGXf/GONElAet/jNRlN/gpYShKK4zcGvXFnlN1WZAOZbuoWTGgOMfmk54/yCC9xw80FkYS8/xpAdT7o1zBfRTKsjvrLqHBxukWWbn6vYOvwZJKHs68cjngjb3njflNdmWzC0U43by4twWPqc9smQU1EW9lXdRnI6ulKr6+wjkUjB0RAOzMz0jlgeOSEj1zXWy2tKqkPgdgwHmy0oyNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHAZC9q8SFP/6VBpJyFqJT7+6tMP6I/iRqvhB7Ot5a0=;
 b=jFj1TXxxrjymAkQYd24b1L/z3lb03fqnQCXktDbpHU5fHiBcBRpMJZlCIc5/7Bod8kYHBspt34cX4MZcVrw9ZU0B23Jy+7IJ03Km087pgeTnujK0POreOoFFTQ77e0fdhEFM13aICj9/c/8p+KoHxhdyLzVg4yyhpnC/9OIVyYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by HE1PR04MB3243.eurprd04.prod.outlook.com (2603:10a6:7:21::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 09:24:50 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::98a7:fbac:5cec:776e%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 09:24:49 +0000
Date:   Mon, 28 Feb 2022 11:24:47 +0200
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl: scu: add imx8dxl scu clock support
Message-ID: <YhyU3/tRI96pDM6+@abelvesa>
References: <20220222082140.2073629-1-abel.vesa@nxp.com>
 <YhkrBZzIDJ4Rgj9x@robh.at.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhkrBZzIDJ4Rgj9x@robh.at.kernel.org>
X-ClientProxiedBy: VI1PR04CA0136.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::34) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f952cdd-44e2-4492-2f14-08d9fa9c2b19
X-MS-TrafficTypeDiagnostic: HE1PR04MB3243:EE_
X-Microsoft-Antispam-PRVS: <HE1PR04MB324315F14F4EB8BA43D65CD9F6019@HE1PR04MB3243.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cZ6YO6MbMKt1s+jyYk1VYa5+mhf9ITIcV8NnGzyxSUkkRatahzX5WHi3SA6bOWVMa+Dm9nY/pMkIFH6S/h8N8CG57lsnyN4mfFZ/wN+47tIjfbtuIoX84c6rwkITelR3HsTxe1QEaTgdPmXd3qhRmnfC6GpblL17rmplPz6HZ/kqvI6Y6lKc8OfH5TzTp+ZA83o1txvskoJ2ldhBrcGDbdqfTDFPhHivGQdTpdmAI5+WCGn/NEi+slK4ZYIYkjo6lRDQLVxMHd9Vl4lafwZsZL9YstCq5u6JBWwgGfGcgq2Z6jBqD8GhonTeZezJC3PiPFdVKzQD6BSzY+IT2rb2lyHrFLhCxnFHep5S9JwOH7WuenmzV30Dpq9FxtuLod8H83Gq/vwUcSmzntPue4UiEMzirOm1OgBzTqSVnYFnWVRDduWGJlvyA3+ke92lzDa9yxjEwWiEzDHTPZP9YfQNnA9yLNVqC8PWB1GwUsH1T+qRhqUBwCtaQIY3katcWmiyXrnsiqJjlVG1OHpk9IUnFIphdiC5a5h3QTPT73SNHz47VktsjYlynIa4gEmY6QvCT7320zmNpnazgnGt4yZeYhrwmEK6sHLHp9otiZkbwpU81OXnT868Zsg6al7zcUPAwwHJPBhxA4iggyIam8CiW1Q5ftbuGom+Bl1NU7mMExb2kablqFn7/pCBCE3IDbQzEKtC72tL63cgsVEG4lOqyvWwV7ZFrg5pjUqsCfoDKJKCd1pQyQUJwnfSYbx3LYveZTUi5kdM6Ue2AGIIS/pASQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(4326008)(6512007)(66556008)(8676002)(2906002)(33716001)(38100700002)(508600001)(66476007)(52116002)(38350700002)(9686003)(6506007)(53546011)(6486002)(86362001)(316002)(54906003)(6916009)(83380400001)(26005)(186003)(5660300002)(8936002)(4744005)(44832011)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UulKJXhQ9SIAlabzJE7gRN3Bxv2ZQdnhFMjts0I9KpONivQRAgmO20F4GQTa?=
 =?us-ascii?Q?yc/IQJVjeWVf6JsiTj/xFo9LPK7D/lm1BSca0S/LtVh1iQ3AzudKYtNNwwXL?=
 =?us-ascii?Q?gRkJpOFsT3KOMXCE0apwdJQ2hISkiu7e2hQ8mqmQueVGYZjcrYd6Ny6RynNw?=
 =?us-ascii?Q?GSMq9cKAkD4Aosexc6e9e+8xqFoPMrMUpVpB/8QYSmVk79iDlnHlVPHwppXq?=
 =?us-ascii?Q?tUSCFKPvCIHiYWimmYbqf3SrksAkMxiUzBZobd0QdS1s0+CP5BuCLlxOHiXh?=
 =?us-ascii?Q?kgmqZhPjFvgiabzwH+QLorwRAYAl2X1rj3issXhSU+9MHpkcfuAjQo+YLVhQ?=
 =?us-ascii?Q?fpJgZVRWrHiLCoZUdZD3LejIVMguRIvLwuFsLPLJFo84D8QyVz8ozYdf+/yA?=
 =?us-ascii?Q?ifnA5Ax7u7aEpZ599gq8Ri28uNWMp+NYCgBrq14AH2YAFfpGwDhPkiJuA8uQ?=
 =?us-ascii?Q?1IyuobEnHtNR6s0Fu7V6btgI+ixporHAxPTm2cnoD0uWwmo9MmgMEOolipTN?=
 =?us-ascii?Q?0nEKrti7vx386hYcvUqrlrZmraRv+PrJ0vYz4CKsK4Su6k9Jcww7JTdAj23O?=
 =?us-ascii?Q?dV5vdlW1D5ApEhqzYQ3e8hGhve0TDVNg1ENqWmvvqSdl3xrz7AO+O7U4fqiK?=
 =?us-ascii?Q?RfJ99wuzDsmRu2SxvSkfBhcQu37ipbBt5CH3H8IXWpNspWnSc77CVapARZv3?=
 =?us-ascii?Q?fDeIDItHZ1GKXz+kwUsyEpCslNorG8nXTMmv7QxUTnT3EjhQUrYNrP7dkZCT?=
 =?us-ascii?Q?YY1DQEIBod1PUMShSBe+MWbwewrL/n83sXf9ZDdHilGLoM7MH2zpyIsZ7dOX?=
 =?us-ascii?Q?Z+5J1zXucn8y5sGShjWtEDR/LE7mTiq5bM/hLsksbIDJq39Itoaf5Cs3PB2H?=
 =?us-ascii?Q?/IWK1lTnB/exsm6LeFj61wSTycM2hOetTJqdvHP1nwE0NkTFfdY8qdIpeTjM?=
 =?us-ascii?Q?numDw5xqvS19ZQlZoNgtq67wPk+m10jpnHC+zf9g/WeLv2hzF01b4h9kIS8u?=
 =?us-ascii?Q?hssB/IX7TASw7TzyATTtOm/oLgEFiY2yqmH8EUfNLMowJAV6IWOJnrhxj6Tc?=
 =?us-ascii?Q?oCjmhTePviqtcY3z3dM9HQRXlJrnZyZVknVoTYCzfnjBTMgyL0wzzGGH+IbQ?=
 =?us-ascii?Q?2rXwO6oaEHULW06/YeQIBFBYDtW/21MYq2IDyit7W/0x7wdkGP5bi15TGZBW?=
 =?us-ascii?Q?Zbn6oMcn4iEEyadTuqNwa473daTicP+SxujD3vJFklBJq8J3M1GVHoQZGpfY?=
 =?us-ascii?Q?GqZGq4TM4dZNG40+lI7f6M2PAs3LulVaBMJQ33ZHntviNriPUkyV7rccU1AJ?=
 =?us-ascii?Q?rUo+kg/ICTD2tzReTGf5rgS/c+tAkQQ4jcRrBznYJq/E3WhXVnGmZv719rjl?=
 =?us-ascii?Q?BULXuIvei2R3hbdOyPjBeCvbpeAWGszUn9h3v1Jlv+1qYp1ozSRMw1AoCl3y?=
 =?us-ascii?Q?ACVTioRI268B/Me7n6bPcGaheRT56W5JJ5tIfHSeQYZdKZIO+JWVkPh4GhQ2?=
 =?us-ascii?Q?paIfuIAMnwRJ63b143kEzO7lr+JRRe3fuWAdMHqNcXcNUOIlD9bneRjgoQSF?=
 =?us-ascii?Q?uqG7Id0eDhG7cz55vOisoCkxXbypFYPi9piVWckX8Kscw4mfhZKAWnisnGQg?=
 =?us-ascii?Q?U6+yUdk3AAZaKichLsFDW0Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f952cdd-44e2-4492-2f14-08d9fa9c2b19
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 09:24:49.7204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ly/AP42pVz6xVF1/er7trFyjTHgMw0iBRq1Sk+3srR2Cd9G6YePikDVx3LnJsT/FBjWyUj3GMg/splBCplzsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-02-25 13:16:21, Rob Herring wrote:
> On Tue, Feb 22, 2022 at 10:21:40AM +0200, Abel Vesa wrote:
> > Add imx8dxl scu clock support.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks.

> 
> But please convert this to schema.

Will do in a separate patch.

> 
> Rob
