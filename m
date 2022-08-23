Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F1D59ECD6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiHWTtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbiHWTt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:49:29 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2095.outbound.protection.outlook.com [40.107.223.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584999322B;
        Tue, 23 Aug 2022 11:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XubDBefG9Zw9o5tFiHDWOSduRMpvkJpY4aZscKGEO01ABHWyPx2SU/e5V0ZxvgV9Fpx3sirA2bo+ZnSduT4JVNEKgocfJXwdCDUY2SAAei/RI9Mx3Mn7Kng8PBLSAGGNl1nUypq6gdjhmYHtsAoblt0M5HfBA/IHLmWdrcoi4SFDEjOZBotpUEem/nB3g/KEJoUIIrDYxHLoDR8hBKXlZ7mwJrd5fsRxzqTLMvlmVuSa8cwbchyYXOFvAQINoLouL3bpHhjSpNAi0MKdFIWdgTa0Qv22Lmj8J/gAg99NwG5iC0cXFJ8y8Ti0cITL2CwDR9d1LywRR/UA1otavkBzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNqpgBJNTeZeiqYZ811DiKbXcv0hy+pEZm4GeStJeM4=;
 b=cMjZ7WoGH5tUu5AjZPj5p0b9cyIy55hAaWAfNQysvPq+6Prtfk5I6eqBN8NqaRr7Fwzc1VhjejLOAiizGiVrNqgM9mJhJgOHn6wuOKJKQKf3s0SXyjO1ec8FtZLg+8yuqp/IyNnbPgNS3XumSzKheIuB6l4WdvUISdYjMjwoZnO/T0YNiKh3oixpFETh5XgN3VuQLpkh4fdNkSUbjjAE9p8dPmJ0/uHem3/pYa8AAuwpclzEIuwrljCTPbkY/dmI0xf92bmMThXu8ppiC440V9ScSdA8i/J4n5+wIzL7hrPhf6dnGQDlgadSvYPW7WNA9V+SxPUx73yJ3Q8C7f+YhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNqpgBJNTeZeiqYZ811DiKbXcv0hy+pEZm4GeStJeM4=;
 b=yU66iTL7QG3FwJXfwpKqGNxSoxQd8v3Iltjhh2bUQEu9XMW1rdYuvLIv1wri+2xG8C0QGB0BzaZ46duZjsNUC6BB5tukbHN3BSKiP2TyzQ6nSybZUk4VeW4vZikYFsXkjJmYtlg8tKCEoYfK90a07ZHQ0jM25LRTMrhhlaOisks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37) by BN6PR10MB1473.namprd10.prod.outlook.com
 (2603:10b6:404:43::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 18:52:37 +0000
Received: from MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee]) by MWHPR1001MB2351.namprd10.prod.outlook.com
 ([fe80::b869:6c52:7a8d:ddee%4]) with mapi id 15.20.5504.028; Tue, 23 Aug 2022
 18:52:37 +0000
Date:   Tue, 23 Aug 2022 11:52:33 -0700
From:   Colin Foster <colin.foster@in-advantage.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, UNGLinuxDriver@microchip.com,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Message-ID: <YwUh8a8prTbTrNqD@colin-ia-desktop>
References: <20220823060052.3921849-1-colin.foster@in-advantage.com>
 <20220823060052.3921849-2-colin.foster@in-advantage.com>
 <1661280427.824099.3761036.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661280427.824099.3761036.nullmailer@robh.at.kernel.org>
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To MWHPR1001MB2351.namprd10.prod.outlook.com
 (2603:10b6:301:35::37)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a0c9a2-eba4-4204-4728-08da8538a562
X-MS-TrafficTypeDiagnostic: BN6PR10MB1473:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: quDUFTIhpBUQxbyLqg9dpJa1ny2wjTHooaBbPbAMXdNZvBF5g+4nxijfu45skn9GMHmdrva5wtIRmcJmHX0zSspXJWVA5kah8lz+2Pp2h+hNO6H49zns4+sdC9GzkUCqDuGj/kpPxCuq5kaEZEGzNtZAtjRFPVlNqzjPg5L+1Dw6Fh4ZqJWaeuo5LatY7lobeB/P09ScWxvsoE2UeTRcjftxyoGW4+PhvK6c4vPb6LsWx97Ag69i5J6HgqWOapAL7uqUdINq62WUoCTo44jFBaq30qSAgK7T9VQVJkd0FChtJP/zM1880bwQJZ+xE45Q5FeTsBbIY8zgljLCphwTOGTMPJ5SNoXJp2NK/14RconqHC9q0lF43cAkAQSSGw9PHVicDR1XVwCiNYqHrJ53zCNokhsLwC5OSmpj2rcoISxcOuNoxznmdP6F8rUj9v4c4gQmG/gpx5T8495K9PLxquokAQCktV4XFh6yYvRd1EHRFLGosBCrGGZkimNwKmzb54B3DSn6aimzs6psklCiFas06BvZ4UritAvC3e/wTN1xlaeImCJ+lBn3zwMFq5BtsROh5A9dyK/ObTmzI4mZIVAwclKnxo4YMkbM2Td6HOCX8sj0JADqZWdAzms3xZcY5sGnzLQk8aP3n0F20vsDTxQWSDCHhiXCpGSxpKCETGMdFD+Gz1KGjsEsMbaJNClOg3luIun1GiJE0K8JrghI1ZkqkG6AREfUeUaj0U3zFq7nZa8wG3zy7LpUOfbVU0HD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2351.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(136003)(376002)(39830400003)(396003)(6486002)(8936002)(4326008)(966005)(6666004)(26005)(66476007)(33716001)(9686003)(6506007)(66946007)(83380400001)(8676002)(66556008)(2906002)(478600001)(186003)(38100700002)(6512007)(316002)(41300700001)(5660300002)(86362001)(44832011)(7416002)(54906003)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zQCmM39IgVilr4HQGyDfdjnzlf1k+0+0ZEf7n0NU0Mwse9kztD0qDn/SReSs?=
 =?us-ascii?Q?zBTgjr3PQGMNIlxByIk3ZxM0Pm/DcySB4cgTvO4xNIeXemCC6enXQxJd0aNZ?=
 =?us-ascii?Q?sSkOHj+iy/qdXk1Z064gxPc6Gy3g5PaGRx+x3cisZnb/DFX7bUsP64LugYza?=
 =?us-ascii?Q?mwm/B21hWBb+QhcPjzux3PT/Jeo+rOFV5cytCE69domkVkHZMBb3uMi8dynT?=
 =?us-ascii?Q?3LpI9PkZKEyK7lTLOPBSXsC0yW7JqMH5jWv8gcgVrzedGnTvFB4apzgEs3/T?=
 =?us-ascii?Q?WiKjkos47Uwx/Xn6iF80LSVNv5Y0LUza1RVpd9FTxoVa6yaMHsGPuJjthJME?=
 =?us-ascii?Q?225bjfLRjmFOnapYKegRsA+P6gi1HunNU/WMmk1Em7Q2IxRMu0CKMX5Nj79z?=
 =?us-ascii?Q?poYF2cbnOirAfAqBhwp1dFbCQh1tGI3ru2pNMFGOCrAYDEjkYmUt4Tkjyej2?=
 =?us-ascii?Q?CuOomL8d19AYewg3Zv/L+6kxBixjxQLNwJ4jrjUJKJ7LJCwCzTOgSBMym4hf?=
 =?us-ascii?Q?ns2URQMyx9Ox58kuDoFWEaO8U6LT98S6ENmjOn5J7fJ0TSIlY0M+rLvD+MDI?=
 =?us-ascii?Q?614OfimH+uu7tQDNBtXnqXPbXMV0YpKEJsgYaMr3czZqSjp8BWVywEYjltta?=
 =?us-ascii?Q?IN1r+aOKMoJEyC0wwVi4GKVfPTgdq1pIIJmczIXpQWUG1ZgwIlCGvRF/J4By?=
 =?us-ascii?Q?ltoODkuV5DYLiSnlWb0tynF24qpgfcVRf5f6w+0C+ryouGnhhutGQm+mRWQA?=
 =?us-ascii?Q?uGRa9ks2WO5HzAkzBaQt+oMvtJGEDn+RV5jCRRL9d22uaH+nvBd4X8VhX5CE?=
 =?us-ascii?Q?7VRP/jgxPFwJT7ubg/j3n10UbUD8JqaOE2MdQI5KYfoWdtkU3iSfgUUbjkwZ?=
 =?us-ascii?Q?Y7dOTmqoRrVJ/i5IsQe+NGDBraDLz1sQbgq2DOziXI/s8vtQFY/h7YIhb0uQ?=
 =?us-ascii?Q?U01/bun/qaA2KXT+tZQfiELnD3ULZfzffQpv+Xt3pYTRxVEe6gt2wDJXcvHH?=
 =?us-ascii?Q?wEQjYKFKIT5OwUa0yoJI/fuV0BCN0HcjWDOS0gJwEBge6M128bAmPu+MF7gx?=
 =?us-ascii?Q?la5BHExuNiGTdB69ubRMY+JfwMsrj9PmhDquRZWOF6JjuL6WxjD+yQ8SJLkH?=
 =?us-ascii?Q?pYDL1sR2RQVrsiEZK2w0sgotwaX76jLBmnwB+Vbck8HL0LBfZUQuc3emBFfI?=
 =?us-ascii?Q?pHWpHSbVUFFVhgeT3N1xHpEDF7bq6IQ2e+mzBcq7tAabs14I/RGXvkBdfnBR?=
 =?us-ascii?Q?OkVMp9X/mlfhD7SkZSjvZnjQoG61FqC2uPEm7pF9ooAQfRBTGQ69Q/4y6Umq?=
 =?us-ascii?Q?bxvwYcS+F2O1lYXtQdpvWaJd/35YyHNNO9zLyADa65Ibr+C5HrW51zIgJ69i?=
 =?us-ascii?Q?eJW66tGFEvQxcpbGV9TOIVn7qVkC5alfM3v/xNpWzamaWJuyum7sK2z5+pns?=
 =?us-ascii?Q?QKG80NLCBSayHWmeOJ+s4/8eYKjOgYG9P88yR3qavo6nVhSSD7dzpChpVcrv?=
 =?us-ascii?Q?b4sQchVF98eSQCdtJz+yYmgkUyZ+/Vx2Co3xm/zvWg0VJHtx23tyqTUmk2lb?=
 =?us-ascii?Q?YbKQ0mhun3PQ+Mv8wV5JqbggcDFITmnOBNytL5PY+7z8zTOjobuvkWPwpkz8?=
 =?us-ascii?Q?+R1OuG8Jg/jWkme/q/DeGDY=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a0c9a2-eba4-4204-4728-08da8538a562
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2351.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 18:52:36.8346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKW0L3Txw369b/y4YPP69O/5upSxKI11hCwJoSt2F8c8GZG13dA7OXE+78qpQFQXQRlWcuH/UuUlNV2PGMvHTZQ0rf4mOdEdwY3/5JpOOx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1473
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Rob,

I'll fix this up for v2. I ran sanity checks before submitting, but
apparently not all the correct ones.

On Tue, Aug 23, 2022 at 01:47:07PM -0500, Rob Herring wrote:
> On Mon, 22 Aug 2022 23:00:52 -0700, Colin Foster wrote:
> > Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> > 
> > Additionally, add the file to MAINTAINERS since the original file didn't
> > exist.
> > 
> > Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> > ---
> >  .../bindings/phy/phy-ocelot-serdes.txt        | 43 -------------
> >  .../bindings/phy/phy-ocelot-serdes.yaml       | 61 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  3 files changed, 62 insertions(+), 43 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: 'examlpes' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
> 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: 'oneOf' conditional failed, one must be fixed:
> 	'unevaluatedProperties' is a required property
> 	'additionalProperties' is a required property
> 	hint: Either unevaluatedProperties or additionalProperties must be present
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/phy-ocelot-serdes.yaml: ignoring, error in schema: 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/patch/
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
