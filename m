Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877AE50B386
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445859AbiDVJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445932AbiDVJIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:08:16 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA79F1BE8A;
        Fri, 22 Apr 2022 02:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idXacIBnsTVktAYEn9rZ3bu3efxkRv5ISt53jxay4VgDOpCGYum7Zwza+5F0LuarZg8aHFHYF7nYiXAWHrA5gWeDpQSlm79jJnQlNtjKG0o+vF9XZ8cClPe3mnD7JUMujrH6S5wFZ8VvFeOeQieXHlndbU2fJgI/H0b+djGSHZuvbfVvHVamg4S9fxWgxOMqdSZ7h/Cq5hnGcTmVMRA8Nos2XXIcvGOjaJ6yO/XFM+85kGiNAJSgTnhbkVliceQXAGt7zhSm5i4bX5ot8amzPhkW0jR/eIKXnKxMFmK6NaOkUwebL078Gxne4Lq3VQ8qJcKl3tbqvMsrVKlyHpDiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChbCZlz1zXLGw8gJ2ngpGKLZFlZdvmW4UDQzdNcXv4c=;
 b=WawozKwDZD0fqJ/NVmmikq+TtOfSmAf1knkGKp2xcqKEWoOw4ciejoXsX+SYkd7h+rH8IvK1RJJ9/HAopl5wAlhwmfHsUG9GceykkkYKXWRoup/0EvrAJZs9/yN8Z44UwfwEJ1cqMNjbbivGvMSj0XsGERyc4DIWch7qDmT4QY/NRd9nBxPL7NgF0C8TjAZzjeKxO/d/eGJRUDHFGkVk297u2ijAmH7ApSDN4PoZZeUcm2cjiKOI3y/hJcDl8nw/CerN5eN+RTvOyikfCObXeja6JKgujJ6HTjLP3LtMuaFT0fgDjtIEvdP8K9d4aQJj9q94L5gvaQyfUWPS4zSXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChbCZlz1zXLGw8gJ2ngpGKLZFlZdvmW4UDQzdNcXv4c=;
 b=H50ixjmvKC+V0WyBjxE9l2fbkMbWoYvVAd+KXjTwYr+gg7X0gs6kk1fvTxDlVlv/KgqJXpwFOU2kTTy6In6H5lq7qsx649zPGY3jRhygtjlIHKpZg6cTPacbfs6lWC75sEq+BJqRbMesDKiMVgTxMaRECYN5uoYEm7bwOEmXDfnHWBTHM1VUynbqkmr7c2iWr8ggXsKTOUMXpxZ9576EEbVC3eCkA9BEHyE2tpoDnLrPKbu65ikFbeZySe3M6/yquYN5STjq41y4lCM+KDe5u343j7CXgZu7JZZD2raJdF1QSs8W0A2rwDG4YVDlaVuyHghCK9gOl8or+4fJtPLjZg==
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by BN8PR12MB3204.namprd12.prod.outlook.com (2603:10b6:408:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 09:05:18 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::47) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 22 Apr 2022 09:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Fri, 22 Apr 2022 09:05:18 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Fri, 22 Apr 2022 09:05:17 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 22 Apr 2022 02:05:17 -0700
Received: from ldewangan-ubuntu.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Fri, 22 Apr 2022 02:05:15 -0700
From:   Laxman Dewangan <ldewangan@nvidia.com>
To:     <masahiroy@kernel.org>, <michal.lkml@markovi.net>,
        <ndesaulniers@google.com>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Laxman Dewangan" <ldewangan@nvidia.com>
Subject: [PATCH V1 1/1] scripts/Kbuild: Add path of fixeddep script
Date:   Fri, 22 Apr 2022 14:35:05 +0530
Message-ID: <20220422090505.551472-1-ldewangan@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbd15f4-8acc-4ae8-b7cf-08da243f38f6
X-MS-TrafficTypeDiagnostic: BN8PR12MB3204:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3204327E6EC4E6839305882AD5F79@BN8PR12MB3204.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nvioYB/Z1E+4YDtBFDG+G2S9e0fmGEYEDtxzaBqmN+SCPsewHJOlKtQB4g2x1P7raEZUQwkvlJJcsfa6SQ0prETYdTXevjXPoycHhIONA0RPh9fD+MTBaSo0lRxbFpfA33HEhvAGrabnHIVqi+9AncA9JDbLF2rFUiStgXhKD6jxVruq2grm/+JHQRujNknQ8caoKfEsvIVZFxHbxYzjAM/jRqpPIwrpMGCAzvObQduOJUBa2cLLtpw/8v3hV0p9pIDOdWbZhq0gYlU3WJ5u+dvZDGDMlqoRdF1NFiXaMhjHRJS5xkiUV0hxEz995irbz3uoH5UpTVyeSaqWNgiqv9BCgs7O4O19YHZk9qrpR/DNg6vFw5v5UTLhJ8RN3/7Yi7kfiNR/YH3ygb18jMndCNO1NS/AIEyXRxKJltvluQtTU7t/GNwDKbk4RT1GaSGeZwiA3a51Yn6z7bELiGuMzpe/XQDj3i1mK0CI+3FNIChOANUiqzWgY0qQsBz/ngC8qegssuJWMQfMEfRkdOXAskPQ51qTidMW1bUgWXswKgEBOB+zEltug88YG4LMn0rTdC++j7nXAiBWzpX9/TzTgDn4LKVi5PIg/m9fhSw3wE00vy/aYlY0S56qK4TC148ZGAOcS/iqIZzJLehSLw5h4Ny4E1PuEusDf8yjemNXfYY4oYCfG4Kz+dh0FQpAB3y4LgcIs58+jW47sxDJCjudp4z1mEfVafLA/hP87AiOMi4=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(70206006)(110136005)(4326008)(6666004)(1076003)(70586007)(316002)(2616005)(107886003)(54906003)(356005)(4744005)(508600001)(81166007)(426003)(8676002)(36860700001)(40460700003)(2906002)(36756003)(186003)(82310400005)(86362001)(7696005)(47076005)(26005)(336012)(83380400001)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 09:05:18.2329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbd15f4-8acc-4ae8-b7cf-08da243f38f6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3204
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add path of the fixdep script from the object tree.
This will make the path of script absolute rather than
relative and execute the command from makefile from any
location.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 scripts/Kbuild.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index cdec22088423e..e07e9265829f8 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -147,7 +147,7 @@ if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
 
 cmd_and_fixdep =                                                             \
 	$(cmd);                                                              \
-	scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
+	$(objtree)/scripts/basic/fixdep $(depfile) $@ '$(make-cmd)' > $(dot-target).cmd;\
 	rm -f $(depfile)
 
 # Usage: $(call if_changed_rule,foo)
-- 
2.17.1

