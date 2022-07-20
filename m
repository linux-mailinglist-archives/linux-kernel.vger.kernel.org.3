Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8DB57B68C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240695AbiGTMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiGTMfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:35:18 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571A278;
        Wed, 20 Jul 2022 05:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxMumI/f3FpBN6kB3lpy6HQCyXxzk9rBUV2gkmh/BBIrAUlGxt5xZNSgu7Yy5hK7lJ0hV6dEUOFF9SNXg31vA2yK78Y5TrQ4F/HHh1UlIePpzLO2dzquBSzmazqWXJQXmuWF+VTpx7eOww3PGnhhIQS4ERN0H3BY98AA9+522CbFYZ0G3+x9xjPXmF86NF1gOMAjUB/1SBOrKPHTs11Is9f65iX+tODkObq6Q+tdhCYa1bV111RGNNla10eO7R5/lI3uH7tPCvaOxLOUyvLkd9DKljnVh428Zkk3HxyGzua9y0dJa3CO712olaWNjc7BcevyTJZPqhkwyKPwfH8fhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5ubwwXabama+oGAa9S8eqZymWV6z17Jxg6pPHyx1g0=;
 b=czB9TJB9DcOOPruvmPDIJm8Ssgy/2xl/pPP/Fe/p95Py4rzor8zDS7hjq9sACdziy+Q227LX6N5HqxCLTDXbBwoz2MBnp/V7ZzP6HX1LHIMvybQYCrK/jvVm8VKASVTZj+AFWLDpPa0KHJeCZr0VqMOmFcZ5jPA17nRVvtpp2IzvD2SEg64fA/mrK8sHrdWyUETaoWYUwGqaFi5t94ESNkHQ3NPkLz7tttEzfzLsymsxMgnETeS1prKU8hj+RpCEAB8cjN/Q1YXqOylRulkAQ8BICfKjpzlxtv6Djcfbd+x1famgVqS3z4UCV6Wu6zs/B28+sS9zS1rva7iOeBJdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5ubwwXabama+oGAa9S8eqZymWV6z17Jxg6pPHyx1g0=;
 b=ocF/k8+tO/f9jSfr54zcI2gIQyswjaxJFrF45eNt0Qvaqx+dWBOXjtr4mf0tCUjyXBsEAR6cBlOuZs8okG2omsTjZq70WvVX3RJDogajxz6ZAE/gXkVOPceq4zqeXM1PMMsevZGV3wSRnzO9OesHFYhGb9iNFlP7FTO9u8vTExs=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 12:35:12 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::fb) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Wed, 20 Jul 2022 12:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Wed, 20 Jul 2022 12:35:12 +0000
Received: from [10.254.241.52] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 07:35:07 -0500
Message-ID: <713cf827-42a8-5164-2e60-7e8da10b91d1@amd.com>
Date:   Wed, 20 Jul 2022 14:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dt-bindings: misc: tmr-inject: Add device-tree
 binding for TMR Inject
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Appana Durga Kedareswara rao" <appana.durga.kedareswara.rao@amd.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <appanad@amd.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        <git@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
References: <20220720060016.1646317-1-appana.durga.kedareswara.rao@amd.com>
 <20220720060016.1646317-4-appana.durga.kedareswara.rao@amd.com>
 <77e8433f-6cb8-eb32-63d5-414a92d3b874@linaro.org>
 <f45fccec-4496-19af-0e14-bd626e14c7bd@amd.com>
 <bc99e06b-1aa5-441e-c86f-0fbfb0945d0c@linaro.org>
 <259a1808-934b-359c-a95f-50d654a48816@amd.com>
 <b2c4f548-449a-8855-fe68-005566711cae@linaro.org>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <b2c4f548-449a-8855-fe68-005566711cae@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a82d5902-a706-4c7d-9d82-08da6a4c4a5f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4481:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PeiT6IAC2Lyfw9FlMeAMcljjHwKIrVBlSos1MROAr9/JnYNCUdqfqlMR1oCKTpAYGcFA6AJV7WLuPr08ZhWbyNk3yQxLGNuPBU64lNDBUZ8oEiRL6BKteAfXsCUP+oMHZ3xYKY7Rr409DiBKsAVJEqNAYbbqLvqjsKdul8Wv8zLESOduIYPrgW2f5qPlHJ1KciPUyien1TR6IpMIjSvtOKhd16z/3zIz2IkfdMcSq9AG5TmOzYydGGBCqy/3tD2713jP1aU9KXKs7mprbtYwSN51vz0YB1LkYWtH1ozphCKl2DXuQRJJ1BepI/KA+wRSqWG3eTO8LxxKTnFPPQQ8POQY5fBIs6ZE25G31a+5+j8sXZU+xkiEWBoHKWcJjP6cnv3tEeB12d806uAplYwhBXSXJQVjBtVrkxR/xehQGCmvGDJm1Ete8UauJPjK/ED1LFuf/ND4T03q/K+KPBgJdKIZ8CVlqiwleIslcWBgrnWuULsgxy0MCl+se2X5mGG4ke2BvB2zw63IIp1aAWPA91Jg2me0Hc8M3vw57eReLqroEmjH1gEN5N6GUZ1WcCIYXDQp42mdBA3+I0GpdL5rn/ta1r3oynEphcwsqxcZvcmOXFP+norwwY6PvfWY8LRKCQL60nhQn5RAenGHyJcLJnAiueDe1iP7xzZSunO9B5JSE6B4G1oRohw46iWgWMRjSDy7VW3pJyZi+EdIP8I0iWuDxe+fLRLtYIEkFCXF3Jn3kmxNActQy4Esy64xTHPL/aeHQ6gnwjWFDKm0a/Qr+B/OfabG/x3J/baG561UuziS5zM9zOTWhTGHn/UiV2NergyH9HNDqY6r45HtxNkXT5p4dcIWIBwjupl4Q3bcPLEob8yCMSFjTrzA9l7skKpP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(36840700001)(40470700004)(16526019)(356005)(82740400003)(186003)(81166007)(47076005)(426003)(336012)(36860700001)(107886003)(53546011)(26005)(2616005)(31686004)(8936002)(5660300002)(2906002)(4744005)(36756003)(44832011)(70586007)(70206006)(54906003)(8676002)(4326008)(31696002)(86362001)(41300700001)(6666004)(478600001)(82310400005)(110136005)(40460700003)(316002)(16576012)(40480700001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 12:35:12.2310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a82d5902-a706-4c7d-9d82-08da6a4c4a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 14:21, Krzysztof Kozlowski wrote:
> On 20/07/2022 14:09, Michal Simek wrote:
>>> Similarly when you change jobs while resending your patch - you do not
>>> add new SoB but just keep SoB from @previous-company.com.
>>
>> IMHO That would be more questionable when you create changes in origin series
>> and new employer pays you to do the work.
> 
> True, when changes happen in between, it gets tricky.
> 
>> If it is 3rd party company picking series where upstreaming is not finished you
>> will expect that 3rd party will add their sob lines there too.
> 
> Of course, because this is different person. The SoB comes always from a
> person, although he might represent company.

Good chat.

Cheers,
Michal



