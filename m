Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E46A4AD323
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349353AbiBHIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349342AbiBHIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:21:45 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2120.outbound.protection.outlook.com [40.107.255.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36668C03FEFB;
        Tue,  8 Feb 2022 00:21:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOT9+nCyXNjHGZQhFtxZiFZ/dcGQszSlcxoc9Ea1QIDnzBOJKMs1kGAFW+1ncLOLxOt2MrJtdX5+jXoIS/+06oBPQNKzbKRoJTlwC9NpL/onvvBRElDMy6SmHAAWAYIcSrvV779YFMazEbXO6U/qI452pG9C9djXDloMqODLW5t75atLL+CvFLbi3fl03BMyuV9sLbr+aYaLu6xDS0Uu5xXSrx89Ovb113kZMeOHVFBg2T6c0loENXh8oqqxxNRCRXV+4OtSQ/fLYevGndob0+FK0ts7CLNP5tpYvPXsXVnGuq0sRIPfZL8NxmQP2n7FkaI3v+DLLVPApMTD+JRPaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ecczZEZ+AGswLhGxbXj01lDhToSxPBEZ3Sbp1zv3bw=;
 b=F1+Bdg0TgAugD5r9FyR8begZOVNykWMeJMA9WIVoSU8w9hbWo7hyeprEmwMSvk20TFUgT15mNRANWSwKy++iGiiNRUauCCspEr5pUynYIR29QVJVl2Mtx3FNdr5XG8aOeSLeXZ+gCTveXpfs+myERZ3P24KAZMulxApaHhgsKR+WPyKQT+hfhGw3SBNDViVEJFyqcAAfvocEfnYM7zzzS/bDVaUXOYaqEKS6STzjIbU6AUylGKF9rbUG6764yqysLA2Tj6njePiFXmWNljen1AUIq6rGeJEsIsaoTLlMvagX4poIFNuObwSW6gEBWvqEkcVA/x1Yisa0vVsRHiduTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quantacorp.onmicrosoft.com; s=selector2-quantacorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ecczZEZ+AGswLhGxbXj01lDhToSxPBEZ3Sbp1zv3bw=;
 b=hlLAc7tq9YtMVDwEJHItjJfCYpo5NOW3mmDsvWDNi3GCB6aPGJ3Wp/mBaR5i4LS/d0VQLBqZQDOpuVzqMhzvJ3nbodsaGwkn59Ghi8586y5LpWaOLfdeQkf5L78CizlL3stKKYJimr0YSyIermzqsdCZkFFZ0PNXGI+WwSHVwE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quantatw.com;
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com (2603:1096:203:89::17)
 by TYZPR04MB5735.apcprd04.prod.outlook.com (2603:1096:400:1f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 08:21:01 +0000
Received: from HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53]) by HK0PR04MB3282.apcprd04.prod.outlook.com
 ([fe80::8160:1a0:97e1:9e53%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 08:21:01 +0000
From:   Potin Lai <potin.lai@quantatw.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: [PATCH 0/2] Add a interface for passing supported PD rev from TCPC
Date:   Tue,  8 Feb 2022 16:20:24 +0800
Message-Id: <20220208082026.4855-1-potin.lai@quantatw.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To HK0PR04MB3282.apcprd04.prod.outlook.com
 (2603:1096:203:89::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b1bfc86-698b-4314-481e-08d9eadbf109
X-MS-TrafficTypeDiagnostic: TYZPR04MB5735:EE_
X-Microsoft-Antispam-PRVS: <TYZPR04MB57359933BB661795435B7BDC8E2D9@TYZPR04MB5735.apcprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O1561WVWiZHI7gjdpbRlNGmSowtle1t1dS1T47+aIIpPaFnV4IFohkpmKp9Is9yK3nQd2fu99rAZxOtzyGR7649AxKyVHzSmrOXrOBLZk1Zgk6Mx0JBvvZWZ8rUNYQq2TfXWnORl04TT/JytwqoSAWCd0MmPQPri5X8tgGiKKBgOisq0jpC5xGTfBzeE3Kqfhe+Z8v3rJhUIDKMxcpk8gisHC6FpqLR/E7aE3k287EClQ0s2ULIYMtMTD6U2MxXihgHsL6UhyYa5bZMFrjub546zCDDYn8vHJoGq+mh3Ya6jNBacHsMSgdVZWrmBgoEkUhKJpLv0zJUHA0cwXt/FTPtef8DnPEcHaKO8294cltPt4v/5z52xDzSO6eVF6oPdjA+QwVomiFpSffDPt0eAgKO4ZTIvVzsPBVNL1xv7wEdZ//6IPDYS00VOPtCcis0Dw667YwFLunBFYAEYbH7S638VV16jjMHHOd/J6d6iJrRK4rxrmueikcxogiJFNu/rbBKfH6/SuEEQ1wK13tre88Smcan3ZFfZIXD5LG9R8W8bFUGFrydQp6Zc7gSpsD+QwY4vgQaFQIugJ7DUYRVW95Z56FhYd6NMjaDp1QXdy1qrLuUKRFl37FQ0aievWVUDPukdONKO8l/gYOEIUCfW3uK4HMdudhj/jI4ppLrT8T+6bmiJZ4Au9xktdT4q7QmjK480f0uNCbJbTRAG+VmbqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR04MB3282.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(83380400001)(8676002)(8936002)(36756003)(316002)(5660300002)(66946007)(66556008)(66476007)(6506007)(44832011)(86362001)(2906002)(38100700002)(38350700002)(4744005)(6666004)(508600001)(52116002)(110136005)(54906003)(6486002)(1076003)(186003)(107886003)(26005)(6512007)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zbOlAbe5zeH/O2wHGKgwT3FWKmMMeX6/Eg2Qc/eM4w4yiBXZEiZZp8iGMhRj?=
 =?us-ascii?Q?axfNS0uhAO7E0KTFrPMi05EP7M4lEHET8jOkJ+KLcAgLS/AyfCEm9q3iPLzW?=
 =?us-ascii?Q?ZtQo1J2gk7EKGB90cAOVXtwzHGpvgiSKuqB5SJaWRMB00LyxlvBb25B9QnN2?=
 =?us-ascii?Q?Cm6Yr3nMpT0GJuyapnzZR+93wR8mR5mEVE5KFFJz7SKeGJ7tg2Zl49DuLG2R?=
 =?us-ascii?Q?TfX6CU1o0mwTKlEDGXR5XiteXPMeiE2FdQGJCsRRQag+9BgEpl/cKrt9tLQS?=
 =?us-ascii?Q?vUcLeJ5dvaAYbGcDVHck75XpeVEhQA343ibTV0ZsmPyuIrfuT2Hcr7piYhd6?=
 =?us-ascii?Q?y5WM+Ktx5CnW1wLDYUC5PgR6SrlIc9InHtSnVC9arQID+/NAyReFPyQrbPjG?=
 =?us-ascii?Q?nlmCjLMgssqW1jIf4w7m1BEnR5SvjvephqZm+ycHKlZn7lYV70wIBbnAizqx?=
 =?us-ascii?Q?zU5xLCJrGBnEswa72MQOb/gVoNMJ/CbiXoRwpehGN3AyYF0TKoEzOXVYfBT8?=
 =?us-ascii?Q?3HXwBAQcMzPxjeIVR5CkXxzZ52ojOEpnFC6kPFjpj2IYbaFYkpxmhbY1xEBC?=
 =?us-ascii?Q?HcCgM0zEnczy60hldJ5yNgnXFjfV15o7qTCiFKJimbUkvvB1UMEMOLXygIXB?=
 =?us-ascii?Q?0ejD1VLB2oVsbHflq/4PspCm0nFgbYKbsrCsIlIQeHBMkh04Qxx4YiMovE0M?=
 =?us-ascii?Q?SmPkO6aJAZFpQ9Er5mjKU1rVx9tIcKgq4Y02mSs3CDuMCz4Sr8UIn+sLpWFc?=
 =?us-ascii?Q?g6JhU7Sr1LIlmL6gvyG6Tj6D9SZPlWkMNXyTRIAvNJtw8S+FGSs0rhA1zXmP?=
 =?us-ascii?Q?aiNF4VR+L/itVkvi/cbX7g7q0w6nWvC3/BykZHRYWyv8MKEM/UfsPjKTIMQS?=
 =?us-ascii?Q?LZxTFQ5uPYAvYZZflFqsC/J6S9m3Vop97kxH9wIP/Nnw48Kb6O9PWxH+ZNiu?=
 =?us-ascii?Q?JFpMbvP+UFNMyVu4Jn8xa0252WQ6/RVaDxwoCKxLMQZVq2CF5HnoZ2PgAY8I?=
 =?us-ascii?Q?3t9U85fUsOzzSOUdR7+aN06GIE7JGReyiNqpXrBX9ynPPJ/F3BF9YteTWFjm?=
 =?us-ascii?Q?ugTk2OG0HCyXNonyzvA9N9TheIOnDnVdO38RAIgbWMNF0EEPOG+p5oTLycy2?=
 =?us-ascii?Q?9ujCbwVKsedCh7A9A5balceFybpQ34UP7gK9cN5CSJgnC2XPZxNpOeYvSlIe?=
 =?us-ascii?Q?ukj9tJmLHnbw7xLwOMsYd76bcZQFbMARRc6gEb858vajEsSTnMmu1hrRr40p?=
 =?us-ascii?Q?JvSlfYjZVTNDHGwksYyhX58DtFeaYSMsP1oYKjegYOnSj3dx/3y2qOvLAqcV?=
 =?us-ascii?Q?Tx6SlKYApqp2hUG9J1xg5WNbWEw9l4bRUMSHBNL9gMstkcYmpaMTe4GZTupQ?=
 =?us-ascii?Q?IQeEICZ6mBH5l7WrKdWx+AHFDpKeLLEv6Hv7cLcvYoY91JI+70NWy08gx8h3?=
 =?us-ascii?Q?e6MI4Bych/7acJGj2gsJb1A5i3g57e+SWgqa6/L0iqubmz+neGYjp9Zm7qX+?=
 =?us-ascii?Q?CM5kBX5zc5NPAHUVhk2GjuC8JV7l5ulBmzLzcChV0t7Zst0FPXP98mZvDyDE?=
 =?us-ascii?Q?1BHzdVhhuYf497lCDFspKhFpsXjoL92mMmmUc0PrmDgkK/6YtMJ9nRdGwLuj?=
 =?us-ascii?Q?hbL/+IrHVcN6Xx77K0Gz/0M=3D?=
X-OriginatorOrg: quantatw.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1bfc86-698b-4314-481e-08d9eadbf109
X-MS-Exchange-CrossTenant-AuthSource: HK0PR04MB3282.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 08:21:01.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 179b0327-07fc-4973-ac73-8de7313561b2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CWPqtIup3Mw0T45F3X3xL+SNe05oibLv3ZMF5aqASxbeC/GNjaVvLVKbAIVHgL/434oc11xk2LAEhxXMoRkjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5735
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add an interface for TCPC passing supported PD revision.
supported_pd_rev is optional, TCPM will get PD rev for negotiation if 
lower level driver has implementaion, otherwise use PD_MAX_REV for 
negotiation

Potin Lai (2):
  usb: typec: tcpm: add interface for passing supported_pd_rev from
    tcpc_dev
  usb: typec: fusb302: add support of supported_pd_rev

 drivers/usb/typec/tcpm/fusb302.c | 20 ++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpm.c    | 14 ++++++++++++--
 include/linux/usb/tcpm.h         |  4 ++++
 3 files changed, 36 insertions(+), 2 deletions(-)

-- 
2.17.1

