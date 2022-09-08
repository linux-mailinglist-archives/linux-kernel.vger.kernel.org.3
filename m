Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4635B23CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiIHQn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIHQnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:43:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2108.outbound.protection.outlook.com [40.107.93.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A9129510;
        Thu,  8 Sep 2022 09:43:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVs0kREGLAa3eGkyq/K2a3JyQMVTJIyOYApKygxp2JNEUsXU/KFvM4fdbscU+5fJslQH/Bp4w2SQsiNcCGTp883HwtQRNYQqMElrKkcGb5Pg/nQMERIbe+gCAIkKLv3NRf1xrzN0ZNnZm0aK6GSGj9NgCU86dVqLFh+dGQOMmpO78N7K7hnEPCLYOd/B/oKsu/eHw/zL+Gm5TZ3M8LzomG3IbRJE/YL8YX+8yGyHfz1tf3PA52y+iR0yusntqAJ21NGUmIu5vDWw7LscjNTHuZC1gXaQAQ2lWJ+MU78xr7kxOJutL5AINmUNuqzvuiVwZofb83Omtw3Qhk7ZUCaNdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SInFHdSksHSu1D3FpPsSSYguSPLcnozcRQni7uiobOc=;
 b=f8Dig4sNtBmYrONpsU/Kfh8z19v6ICb2HtTuhoCOysaqqNjL8EL9tlXoQFvojpWJn4JtopnKdIvVcwmc5GyexweFpwH+QBZl/L8lzGD6c68/MZPV4RgJvfVXRXyMtHhIlDEE3bgoXEAoCf0I0aR8/xHTEYA7hZFuo3yxZ8k+3iA+fFJ0TvxHD6e8L0/rr++DXiOLJg06fMEojZ1YvwVeRnz1qzj/8Ee64khZVD1fL6husLweIb2fntM5Mg8Ar3RsxIdYnVrFU/3G5qrJViAPZW057CpDXY6Yu6keOMnC/vDxjPxaShzjRivd9b8SOdLouWKPWbaNpbv6PgDUguMHQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SInFHdSksHSu1D3FpPsSSYguSPLcnozcRQni7uiobOc=;
 b=GF1viP+AkcIRlf0vq4kgXNpXAXp2IX/lrmKDSPmiaUD879WEcGcbjZg5z+BijRtPxV/e9v+6v3UERuzAuGwIPtB/61+4d/+CyDf0KS5wJDZgX1o3VfdQiw/bbFKY+DlN/e9CtjZbVYh/Qv9yUNowmGCzPek2hqQbDHrK/EuZrJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from DM6PR13MB4431.namprd13.prod.outlook.com (2603:10b6:5:1bb::21)
 by DM6PR13MB3865.namprd13.prod.outlook.com (2603:10b6:5:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Thu, 8 Sep 2022 16:43:39 +0000
Received: from DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7]) by DM6PR13MB4431.namprd13.prod.outlook.com
 ([fe80::2944:20ba:ee80:b9c7%3]) with mapi id 15.20.5612.011; Thu, 8 Sep 2022
 16:43:39 +0000
Date:   Thu, 8 Sep 2022 18:43:26 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>
To:     Joe Perches <joe@perches.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oss-drivers@corigine.com,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH v3] checkpatch: warn for non-standard fixes tag style
Message-ID: <YxobrsQTWNUrlfkj@oden.dyn.berto.se>
References: <20220908114325.4153436-1-niklas.soderlund@corigine.com>
 <2e3295bca268c37aa57fb5b14da9a4c1795ac067.camel@perches.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e3295bca268c37aa57fb5b14da9a4c1795ac067.camel@perches.com>
X-ClientProxiedBy: GV3P280CA0083.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::11) To DM6PR13MB4431.namprd13.prod.outlook.com
 (2603:10b6:5:1bb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR13MB4431:EE_|DM6PR13MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f323766-cfae-4e1e-6f83-08da91b947fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ig0ARQAQVNt2MVfFBOLt317acd+eYjUQ71mIzFuxH9Gx7kDvsbcZ5V5iNRQ9KhNkXgYRxW36J5LpVDt2MhTD32YH7XPJw8ni2IkSeTdjZFgEr0tYl+/8n6wZaYT8a3skEalatozW3ASch1tqE7B0qdeAokgfz75LBVnO7TLqLwOWROTy+7EqY1QbwQJYvvyD2coJIQdj5oK+tyxoQW1l/OiOfwYs3aFYcMjppbcrNbjg3/NTwX4czjQKiVjGdB3OfMuWrRTT619mCvXzbtIjavipuKRO4NhNSE50uhSwME74n+hBEWYSZZ4zjC+3iTpqLLO1/xhCdd/8OYxZcM5QVMbwcEjTRzR8YhlbG9PNGB6pULEyB4aGHbO23zg05qAkQEYSUPaawoFXbJgN5BL3TIRJj4dF6n8YcKan9wJccERCmVCzUALFZQccEFW+jKHmVy1aXv7a67zP7yJfhO4AG1809WBzOCKplqaOzGsNzwgqfEEygExsCoPnS3Rk/6426pjIbd1m0PPkCEahICVyRS9UgEBPsk4Lt7xbZG/pCXYDNtYcIgAeMqiIV1y5P+WwKOu/7jk//GtfO0DvFQJAfaq/dfSyq/i9nv0QlLUaIYeMtCJ1x4DX3Yfuspdh4lxnviwXTKLkkAtI5xohvK8g5gFlgkNmuvP2ps8oy2DJDqbBwnUKByoMUalKqPOB9OyM0tITpZDi+VLoEEWFaFYAg231FKFLLwDK13ohjJBybDL/Sn0PWI1B9cjkKqR9XxvrIq/RoCv2hHEJ11FTCGhWqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB4431.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(346002)(136003)(376002)(366004)(396003)(8936002)(2906002)(5660300002)(38100700002)(38350700002)(478600001)(6486002)(53546011)(52116002)(66556008)(316002)(26005)(107886003)(6666004)(6916009)(54906003)(4326008)(41300700001)(8676002)(66476007)(6512007)(9686003)(66946007)(6506007)(558084003)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?km42uW8JaLBBI9fjIs8S6LsUE4pN6lH5A/cgdIhRhXdD5EA4IPKdt6PWqk?=
 =?iso-8859-1?Q?8f9oabVFcQ4roN6HDfrsCSmuYtQu7sWFlhZu5V/WpVoa9uOHvMuewNRnQr?=
 =?iso-8859-1?Q?TuuEjCkHBrn24lmykTuRtd+DXGmO1TnyfHacmJYtj/SFtcJ0caHSlONTJR?=
 =?iso-8859-1?Q?Eyu8k1iDo7wRktgUdfRxljnN7AtOwWGfeTUV0Q+CjQhDyorfc8g/WHD3bu?=
 =?iso-8859-1?Q?kcOcQCa96ZTKYWSfwH1nyAaYjs/0IYGcbvxZPumnxQnAJaUS4qtuXeL3dH?=
 =?iso-8859-1?Q?K36+tsCmp2uoyLMCahOkiuVKjIQ8c3BzBzmKnxI/uK65VFOyLebeYNGhWy?=
 =?iso-8859-1?Q?bwCDtx2ESPDQPljEOSxGe8i4rzwe79AziVHm4eWe69fKjw+nhP57LEbEzo?=
 =?iso-8859-1?Q?l0PNb80FKu/Q70svuZXESY958S1iTvClYKMaSO9l5cct3hJjJ0KrlNdW4O?=
 =?iso-8859-1?Q?bDcGs2wCsy3U2/TfK8rPMZSNFkbhjrO27Jue81itBwgLf0zxxTDmfCNssJ?=
 =?iso-8859-1?Q?vHs1DTw0/PCqzcVr9N8ycmkWRq+CehXCooW45y3+K3bM2J0ast02KAqqtO?=
 =?iso-8859-1?Q?luVqVps8Mm7GykP6j0fTebbjx0gm4rbld0395e0+EfVEQFSbhLV6ONvTD7?=
 =?iso-8859-1?Q?qqDsv41LrYdF+CHSfAcHSfgg/Br5ThGLdK/juiNqllNply/rYhEoRgK59D?=
 =?iso-8859-1?Q?EZOsaXTDit8+T07NfaV4NS9CdvMemRbnx4i9bAuWWIe7ACT85SJxtdfm6V?=
 =?iso-8859-1?Q?bq5U3TaZANotUtXpS5zDtyq0yzkfnW2SGE+P5DsWpmGR5+o4qE6QeROoHR?=
 =?iso-8859-1?Q?EavM79skWzaX8tXRY3gbtpg3sLP3ehG73CbbYHcAP92NVAomGDRxiS+K2r?=
 =?iso-8859-1?Q?5ogEqMPRAqhEvAtxD0BdVQaqw9fkiaNeuCgKXLcaQRlasckuBbeLZwd44H?=
 =?iso-8859-1?Q?NcAOAoVWFPuP8WaeWQEzom9ct/rRaFvRUqpyU8lOJMeIa2RCMSWYfWZOew?=
 =?iso-8859-1?Q?Sf+RTjtG8KBzI49IfAEGQ0ER4F0eZbBHPdyxbmXq5+f5alll5PkOEHl0o3?=
 =?iso-8859-1?Q?wpJ0SzhCvP22knEo+tr//OLpTDxV2pLtHtRLnpx4Pgnzhowi8kYUJUsRaC?=
 =?iso-8859-1?Q?uBXQNVDyA+UNHn8poQ/CGMQ1g+4s7WVZhfBbdLYU2dRajjFPu4SRbA6oPr?=
 =?iso-8859-1?Q?RoNPnXuw/JQSZbv+4sWIW1bwP7XLhSN4pdwA+AG8xFedTk55wwIAmxaoze?=
 =?iso-8859-1?Q?4bosJCgy5QPD33SkscOdIdg/KCFltCV+J89WmbFL6zHsd9hiwvSsoHtACV?=
 =?iso-8859-1?Q?MUCN0IEeKVxI6BIN8S1jOHuSBmBeJoq3FKTdTQK1Af5Q/5rqWb2xiXVvpZ?=
 =?iso-8859-1?Q?uB1kPnct1JPk1ee5gwj0OHeXfJ8xA8u/zlKVPW7LVP26nB9/2r5uUddoqb?=
 =?iso-8859-1?Q?xYxYr0brWUNafSTQE+fjxFUkl3UjU8wu/3lwzH5iRTeO/VIUS1/XLFymUR?=
 =?iso-8859-1?Q?J7gN7WPGzxI358/VAGvczzcMAo65sGiw9utwuvmd7iFaXwHZdNgvaD+tMS?=
 =?iso-8859-1?Q?M8MO1iwTMTk5ir8Mhy8YRhZutmD/5iQiWEQA1foqG+JuIItl+0a3Zpu+X5?=
 =?iso-8859-1?Q?vL9519MfB1RZcszEldx1h/RMtSEFt+LTD/G9zMmnn3s9BFRy+UTn36FA?=
 =?iso-8859-1?Q?=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3865
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Thanks for your feedback,

On 2022-09-08 08:09:01 -0700, Joe Perches wrote:
> Maybe add another test for the title being different from the commit.

That is a good idea, will do a v4.

-- 
Kind Regards,
Niklas Söderlund
