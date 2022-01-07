Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7041F4873B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345102AbiAGHoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:44:38 -0500
Received: from mail-eopbgr00126.outbound.protection.outlook.com ([40.107.0.126]:41958
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345111AbiAGHog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:44:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9ft2JzR7R+UsOHihaEl0IJM88cUR/RKuyqmo9z1HQNGJuSxFH9vroyXduyG4wzgbVcsPDWxukSHf2Wnu+kQ9/fV2SJtM6GrXfx1vJIkNTkLBk95Fe5dbBv2+XLNyh3X61wUOF7Vo6clLODMhMUxeP7jgZDNZUT6EBN3wflK2KrB4YKSZM0wZZPSzTM4UFrACPwdVItbbMRvP2OM1MY2OKXRybkIeyC9HXfLqUvMy8v2RMaxPJsUFJ25sGa8EH0CzBDwvYxe85eRmNPDdSR/ROFXgEQpdjO1aqYpIPtLO/uT0pF6lBZhSWetGsxGGzw3t7wCYl+nNu4jY54yogzS+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aAHgff3nOtP2tt6hP5lxE2i/sX5IBuizXGUQnjuKMs=;
 b=Zm2BW3yGOh3HOBK305FFVOs94VGh+gCyOfBcXSbGhmrGTauBk3spxExxhHzFgZcOpylbTtPfyNIb3hEg8EPwfV77zupuufEsMoaoBMN3789HNHG2YVEC0TXH+vPw65wO23SeCRgFkTMF6TTMNMFo17Y7kBBWr/DSLD2CyY0mteln1Vi1oytuvjGlJrNbpD6ooBzEuX6JgU6IVWwqAUn7OuV8rmymDh3X5hOcsbNTARaR9LPEqCwPFr8LjyT22YQt1M7OAYQbQ8oCAnQjlZ/Jbq6Gw6VMf44YBuopEWkvZeMOO+t4wEls6BrnLRiG6qiiNO4P/KA7Mxslxc1hIoSk5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aAHgff3nOtP2tt6hP5lxE2i/sX5IBuizXGUQnjuKMs=;
 b=PB/92PPL4zKeS7kPCmpu7SmmCSXB3XZ1OYWZ9AgTa6ZjNGKmlpVUfNq/eAm6fuHEDnPoRLYCVrUQNtgdQ23CaW6ZwQe7UcuDOrtZt+7xxzPuMzRVGk4VzAJnPeMbJ0e1eRZDXfcweAaY4gv06rUBsYDTIZ0/y+kKbJkVMfvPffk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB6PR0202MB2792.eurprd02.prod.outlook.com (2603:10a6:4:b3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 07:44:34 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::99a:847f:ce2e:745%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 07:44:34 +0000
Message-ID: <6f8cfdfd-9fa6-40d1-09b3-0c9fc50835ac@axentia.se>
Date:   Fri, 7 Jan 2022 08:44:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: sv-SE
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH v2 2/4] mux: add missing mux_state_get
Organization: Axentia Technologies AB
In-Reply-To: <bd26e410-b2c4-888c-9bef-efc26146e366@axentia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR05CA0358.eurprd05.prod.outlook.com
 (2603:10a6:7:94::17) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c3335ec-0a04-41a5-45f9-08d9d1b18c8c
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2792:EE_
X-Microsoft-Antispam-PRVS: <DB6PR0202MB279206B7609159FCD5CB5AEEBC4D9@DB6PR0202MB2792.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQ9ZI730uBKNaoH3SQ60mhtWB3GwoQ7GQTe8yZ5Vn+FB8yD6uYEtkzKgW0DuKmst4F8ShVOMURT72cM61SUhT4i3XXKbNHfuMlwUEbs6yln+jDTzGt2KtZW8nIiy4/jw7a1MedcJjUBWHvSV4ZzBAgJL5HUIwpTgLYsS00CGig5WA6CKvtcrTaoygWsoKXjRTDzAJJEEH/rQTnxYGdFbkn7N6feB8nGyX97EpTpvbLb7WfyJZsTeilPnD2fbvGjdesvkLFy0A5c80sKufr9PoxaY9rGwCEECu0gUgcQufXPAPKZr95xY/Qb6Ke3e6PIFGaMIYFhxN37o5psJTFjS5JkDbGy8gZCa+/PGNEpmh/WdvP59fhqtO4K0s8l6+7rL2c1vbh9nxVW0Re3zuGVfUbXi3KuTkYkrlHNIElWtjdZjEFo0ntFQz60Kj+Z3V3CFAJfh0gC2cBQi6DV6Jblp9Ca2sU+YPAXWefFLjhz9/YEk9+zJl+vcuhdRBcPQSZOykhIFn/6Nz8Usrp6MqnDB3fuCrkkDfrhcvlVn/vfNY4D6+RUaCTta75m2GEf5kt34MEq6MZGYITmhhAfAtTw6ZTmyTY4z/1vRBHc7QrqgRMduHhW/B5RNlOltuodmry5fDJQ6sEvq+t7uo8VgNAO/uw90cWkxWH45HT29nR792H7Z0p5Ax2hSqV71v/0QeaSLT3r/I3joiSHkmXtk0TdvKGTvwI5s16OcR2vXQScfeRo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39830400003)(136003)(346002)(376002)(396003)(8676002)(8936002)(54906003)(36756003)(31686004)(6486002)(86362001)(2906002)(5660300002)(83380400001)(6916009)(36916002)(38100700002)(186003)(31696002)(6506007)(26005)(4326008)(6512007)(2616005)(508600001)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBaQ1YxQTJEYzJ2a3plakVic1VmOHdkNmtRVUFLUUkwYXNIeUtPLzZ5ZEZx?=
 =?utf-8?B?Yjc3Y2tQVkxqTzNQRzhkU0I1dGR5T29senRWcGdTQ3RXZThNRFF4K2diSVg2?=
 =?utf-8?B?T1gyU2tBeXdRZ2xZY3M0ZnE1Q0RCbFZ5VXZHVHNCb0hkZXRiZUc2VklJUUpz?=
 =?utf-8?B?RSt5YUs0cEVqa0hORWNwbjZjUzNVNFJrV1UzVTVmVnlvNHJnQ2NEZmc3UmNS?=
 =?utf-8?B?empzT1FKTGl3RXZoWnVzQzM4R0MwMVk5NlQyY00zUFBhU1Joa3FocVJsWXdN?=
 =?utf-8?B?MlFBVEdtemc0S2s1Q0FKSkV3NCtZL0s2RllmNmpmQTlWN3ZkSXpEbUVRQnhB?=
 =?utf-8?B?MmNzVDFHWUJXZWszSGxDSGRjSXRQRXBIYXhsRGVCY01UYTBhTjlKelYybkJq?=
 =?utf-8?B?Y25leUYzY1RlQXZTNmF1by9La1lTaEdLczg4S1l2a1g3VUNwazl5RnYvS0Yz?=
 =?utf-8?B?YXp1eFRBbnpXeEh0aUppczkzRWV2T3A5dkV4Y3FnRmFuWG9EQktacnJCUlFu?=
 =?utf-8?B?VVBPM3ZsSXV5OW9XNlNzcjNhRGc2SVBVTmlWdHE2ZFNwRURXdHF6TGZwK0Vt?=
 =?utf-8?B?ZjlHT1lGSy9GTEhvanJMVEYzSzZpU0FzdFcyV1BGS0swZktpUE52bXU1NkZ4?=
 =?utf-8?B?eGw5WGVKNlBkSEZjNTNsSEtQUnBjTDBsQ1RQRTdLTzRRd3NRUllqUTFMcy9i?=
 =?utf-8?B?RGF2Vzh5U20zRVovN0pmb2t5T0dDeElDMUEyK0w1eFpaN1lsSnZNVkJiM21T?=
 =?utf-8?B?Z1hRK0phcDZNaXFCNVBVYTZ5bjBIUGRqeHRDZTVuakJmbDVxNndmRnlWbTFL?=
 =?utf-8?B?N3BZR25JN3N4WXM2Vm1CS1FqY3pRZlBORHJWMkZUODlKSzBTVmVrcVZ5d1FQ?=
 =?utf-8?B?eFoyV0l0d1VoUEhYZlFsUEgveDd4M09Qb0lBSkc1OUxEdkFqMzEvbXZFT2ph?=
 =?utf-8?B?K1pldFNpalp5TElHOXRQZ0ZUeHhGdVRxaHo0a1hMbFd4TjlaVHljTkZzSDhj?=
 =?utf-8?B?NUtuWDhlY2JTMjdTWGllSTVCN1RyZURYUVlxMVJTWVRQdFE3TnB2WFc0YzFt?=
 =?utf-8?B?eDgyekFGZXF2YWRBM1VDL2ptUGJOY0k1elJSNDZ5UHBNcEYyUEU2TmFIYnpx?=
 =?utf-8?B?aEhhaC9QelZqL1ZSd0drWVVTR0h6SEhNYkhaeURVM3BJS1FzM2V3NldlNzBy?=
 =?utf-8?B?WnhmNjhsdXJBM2NDb1BXU3J5WFV4M1RlOVB6VVhzU2VUd1JaMmFHNXVqVkpO?=
 =?utf-8?B?cFNGakVSbllaWHhhRWRCWXgydkpGM2hERHdtYVBlTHFCQ1BEdHRtYlhQS056?=
 =?utf-8?B?MENmdlZWNURxRzF1N3FDSmVRLzhXMWdBa1JITWJIeERVRHJTVXVUYjlHbkpD?=
 =?utf-8?B?cE5pNm56SlV0SDlNcmc3N2ExZ3I1UjB2RE8zcGl6eTN3aVozNGlKWUZlejVK?=
 =?utf-8?B?Z2hZeko5OHlWdlMxa1pCRlZWNS8vWmtxK3RsbVNLOHRSWTlPS3FhUFhkSS9H?=
 =?utf-8?B?T29IOGdoY2UvNU9nVzZuTklOVENrZkEvQ3lGVEpJUE0zZFQ1U0ZDbUJENEFR?=
 =?utf-8?B?a29KSjZJdFBWSnJ1SmlwckFrc3J3M3BhcU9oZXMxQ0R4T0FRU1pvNE5KdE83?=
 =?utf-8?B?UTJHNW93c1NUUnVmZGMwaE5ERTRTSXVkSEZtMTdhSkxKdkNLdC9NSzNJWkJU?=
 =?utf-8?B?R1I3cEdGYTBGdGNPVnp3SkRUTXNta1daMjlWL3JpeW5GMitUeExEUk9pSVJq?=
 =?utf-8?B?bHFzSWtTV0RZUkh1cEx2ZDcxdU41cFVmRkRMWDNkZHMydk5NN2txSG1vU1h0?=
 =?utf-8?B?enRLckVROFZtcEJQNHVZWFBTVTNBOE9FN01YOHViVlZ2NzFjUkdFNm1JQmdM?=
 =?utf-8?B?ME9tZkJPbTAvdEw2SnlvYTJoUlc3NlQ4anJaWFVGMkhPYWlpNXY3RFMva2hO?=
 =?utf-8?B?aGJhcVVjb1VhUWFyS1VoNmE5UmhIQk9iekJKdlNaeHVXTnE5dDZmbjVvWjZ4?=
 =?utf-8?B?MTdlVHc2cDNlZ0Z6MUVla2xXbHFWOFkwV3V4M2pOQnNaMzdYYlN2THc4N3Yr?=
 =?utf-8?B?UElSdWFaNXl3VjBqNUhrQSs4M2RJVG1nakpZdGNhRXdYTUxCMGZ6eXQyN0hj?=
 =?utf-8?Q?y5y0=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3335ec-0a04-41a5-45f9-08d9d1b18c8c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 07:44:34.8305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GImJTSfoOfOtbpvxS7IgzIV4UcxPpL7u/nuOuPHD9g8sG5NfwXbgchgeGdBTXeg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2792
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And implement devm_mux_state_get in terms of the new function.

Now we have both mux_state_get and mux_state_put as convenient functions
ready to be exported should someone ever need unmanaged interfaces.

Tested-by: Aswath Govindraju <a-govindraju@ti.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/core.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 931fa8bd4962..5cf2124fa55b 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -673,6 +673,32 @@ struct mux_control *devm_mux_control_get(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_mux_control_get);
 
+/*
+ * mux_state_get() - Get the mux-state for a device.
+ * @dev: The device that needs a mux-state.
+ * @mux_name: The name identifying the mux-state.
+ *
+ * Return: A pointer to the mux-state, or an ERR_PTR with a negative errno.
+ */
+static struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
+{
+	struct mux_state *mstate;
+
+	mstate = kzalloc(sizeof(*mstate), GFP_KERNEL);
+	if (!mstate)
+		return ERR_PTR(-ENOMEM);
+
+	mstate->mux = mux_get(dev, mux_name, &mstate->state);
+	if (IS_ERR(mstate->mux)) {
+		int err = PTR_ERR(mstate->mux);
+
+		kfree(mstate);
+		return ERR_PTR(err);
+	}
+
+	return mstate;
+}
+
 /*
  * mux_state_put() - Put away the mux-state for good.
  * @mstate: The mux-state to put away.
@@ -704,25 +730,17 @@ struct mux_state *devm_mux_state_get(struct device *dev,
 				     const char *mux_name)
 {
 	struct mux_state **ptr, *mstate;
-	struct mux_control *mux_ctrl;
-	int state;
-
-	mstate = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
-	if (!mstate)
-		return ERR_PTR(-ENOMEM);
 
 	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	mux_ctrl = mux_get(dev, mux_name, &state);
-	if (IS_ERR(mux_ctrl)) {
+	mstate = mux_state_get(dev, mux_name);
+	if (IS_ERR(mstate)) {
 		devres_free(ptr);
-		return (struct mux_state *)mux_ctrl;
+		return mstate;
 	}
 
-	mstate->mux = mux_ctrl;
-	mstate->state = state;
 	*ptr = mstate;
 	devres_add(dev, ptr);
 
-- 
2.20.1


