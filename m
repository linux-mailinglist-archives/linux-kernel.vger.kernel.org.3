Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C334C511FA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiD0RdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243967AbiD0RdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:33:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2129.outbound.protection.outlook.com [40.107.93.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118F413BD4F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeWApeSgBfuYHaDEUVvAEHkCqOsyCjOjKKnl2HmIhLvhXH572ZRwyzUPO9QidVeJqQ5IgBOUFrIW/j2ELOIXqssdpdNuB2wOf+3cXK7wlbm7+/sQ8SN6mltwklvISzDmpD2uNf63SGLH/2NZSH/PFLKzlRW8jmxQd+nniEoMqU89KKw3ih02NhWS6l2u8cPFVaIiqV30pWN062dI6+UcGdd1E6rvbzOo1fTzD+jqSA2/fdn0z1bwd6uj1PAzdEvyLiuOW6iUf1hV0FhUjvRP1gHCEs8kyxp63TAjHqW7/Y5OWqfddo4/7aWLCKqbDcB3HCyyQ22kLOwHAe9rHcv9Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD9X1XBgdDN5In+2MiccVgV2oBA8Z3kGFZhVlE5EusI=;
 b=Gx9b1Y0tIrv6rMzW4ek/RaysmvwzY2DCcfRSyJIIB1lKPZCo7D5C/6p1tpxPPRRwxma3Pdv5O62Sk5N/1RmZCwaMAJo4/QBF7uQWlgn6vjJIZwRAENMgXzo0CZOcWySj7zbcsArMy3DHzk3UCc8jTG+inE/jSfdU0zV3Q8LzLcgYN+IH1/6wG8bvPXgba7JUcVkBpiSd/TxQ9Yo3eC61o+4ahMyDIakk3JdO2ryHiC+rIdDrnpksrRYN/J570UVKVQEtILiSYy2skCpdgKNYDZdWVUhMxGOegcbBQ1lLCqfWp7ao6EFas7vhjz19r5Fn2HKpkmTSh2KOMoxbZffppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD9X1XBgdDN5In+2MiccVgV2oBA8Z3kGFZhVlE5EusI=;
 b=Wznrftff1Unb/tzd7f4Yk6lPbgVqf2Uqypa27zkeXQJvUg9BlMKUyshayOPqmG/R+IO7+lztm96ykMEadYwYv8KPvvlKnMUFbDNb07a7oi+yfxAp215UCZyIDaXx+VV6fuzVeP0qJxKvpjB1I2ZVVJKFQp4EhZ0tRBD/Uo7839w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA0PR01MB6329.prod.exchangelabs.com (2603:10b6:806:ee::12) by
 DM6PR01MB3642.prod.exchangelabs.com (2603:10b6:5:90::28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Wed, 27 Apr 2022 17:30:03 +0000
Received: from SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6]) by SA0PR01MB6329.prod.exchangelabs.com
 ([fe80::ec31:ecc0:58a6:25b6%3]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 17:30:03 +0000
From:   Darren Hart <darren@os.amperecomputing.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "D. Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 0/2] Documentation/process: Add Ampere contact to embargoed HW issues
Date:   Wed, 27 Apr 2022 10:29:56 -0700
Message-Id: <cover.1650995848.git.darren@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::32) To SA0PR01MB6329.prod.exchangelabs.com
 (2603:10b6:806:ee::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a9200b0-4b09-4670-df5b-08da28738f87
X-MS-TrafficTypeDiagnostic: DM6PR01MB3642:EE_
X-Microsoft-Antispam-PRVS: <DM6PR01MB364206F6E31F03C53E0CA6D1F7FA9@DM6PR01MB3642.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPfnwqN3GYnc9aifFVfEMMlOaeVRxqGK99TiwE10DCBmHLeyenH6/D4PRggfwIf3N6qJ+qEjKC79GEi2nBKm+BgoVs40DMNUu3ShaDvNUQ1SvuVcjiDKhtKHRDclNg8FRQ6y/FWC1cetaEEK5AhKH/81GMUZdJmCkVWibeT5RG5MFoleZXICthlrCZiLS31znzTMBaU9EvE8+QWtd9rRwO0stI1r3zvNKKcUNiTbBULD3eyH3Bgu0r5Zt03fC5tLD3nLYvkCss4krqD2aKhp5k/Gz+v1TZV5c6OihA073nmP+F7Ek78PzlQbLBJJlfh+jPQ4LsAnE4laop01pFF3O+OrJ7UyZpfMSNnWfwQlP7qnWlqzBNr9i3B7p95WpT+Tn9uWzc9kZY9g0AunT6VRaQ1astwU02QIfyvvOVp7Dy8lpr2WlO00e1OzmDFiUhsMkoY/7WQG6c4rQVnL38u/5YSTGvL/sp9ysHIt07YGZGxanzRG086gyZ4aMLtwa1pbTHyAhKydi5mA7Kv9fZTsL+1KVnNnSnef80Duc+k91Af2SfYrPKp/6yTCJQgglucFDNlJNiwcVKBDJm+2G8NtGowOImK/oP5DrQ2DaJhHiWBVyuxCdY4zepScBEYE6FBtO/zP6U6NWpvi4e/3O9i6sSvlyjiwaNDuXsk/AFKgBE0054KoRO8uzvqWmk3djGyWxThQeUeKA2gcipTaB1itfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR01MB6329.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38350700002)(6506007)(6666004)(6486002)(26005)(6512007)(66556008)(2906002)(4744005)(5660300002)(8936002)(66946007)(66476007)(52116002)(8676002)(4326008)(83380400001)(2616005)(186003)(6916009)(54906003)(86362001)(316002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TVXmIpmKaom9IAnHUA5PGR8W0/TlV+z1AK49DA69/fhsxxKedwldd5jbVpMn?=
 =?us-ascii?Q?BpHvFyxRppHxaUs9ZFiuLvS+NjlkDG/FnaG6LAsgRxfEgeYoJAQnojSRCxS8?=
 =?us-ascii?Q?nyMAHaX5sJUZ0/F0dcQ11AmQIOMbYlLEXcOmPnhBqt1L8YByvUQWwC6DHA/J?=
 =?us-ascii?Q?yT6MQanx5aW14T/lclkbdbCvY/QccLP0tDc0GY7ypoLiUCbZKZjfJL5+6jPE?=
 =?us-ascii?Q?gvdNrD27Ub7igEynoFBrxP1/tTik0nc4tZ1h5RJpxvQsfNI1s1Bpqpd0B7eO?=
 =?us-ascii?Q?u8eFddIirWW4f6XzWlJGG0kZobgntX4Cg6EVLYmBS0OfHwFN5M33V1adoqD1?=
 =?us-ascii?Q?93IvMlyPq+VUOAhgXGGtpPKN1F6nJYIi5wpfWW4hUaF74kU4ONY0iiEKT93d?=
 =?us-ascii?Q?HvZLa5x7weRn59eV0vT+WWAxwn+WFyBCYoG2466rK+et7I8CSOyJ1MKYFkkR?=
 =?us-ascii?Q?uvIt+Eky9baqvFuKMxM+fAUw4xj9RIuGRDwKe8dbF/AANpjy8/MqSmwgDcLZ?=
 =?us-ascii?Q?K4KPceFi6UcZz8cEkOZkN2fj9bZrmPaFUj2pfIhLIGUEku2IE2eBJ02FjnQd?=
 =?us-ascii?Q?iMybVXWb0OZ9E7YjPa5CPbI07k99SLJIQ6S1uXyua4qxNcYpN6lVcpZkvLdM?=
 =?us-ascii?Q?3xJ9KkpGt4ESQ5yooZccjkq+NngBr5tBXVqPicW0U25cGg/tIHeICwf4inx6?=
 =?us-ascii?Q?hYk/ZDNdPtyN1+OVkNZWnsSz5W0Kpdh4aQF2ANDEBxUDqUO4BefJ0Py9GOt3?=
 =?us-ascii?Q?9xoPTrC1Xh/7vfecHX6g52S82m9SQAEKMo+JSHx9sA/F8YwdHkyA4GSCS9l3?=
 =?us-ascii?Q?zEj4oNG7Cw1bpHCTJV8uJAbwHQNFwWqCtEcZ1DF01fR8sUjreXbdAh+oK65m?=
 =?us-ascii?Q?cS0cp9dT3c6XBP+QvcGxzhKIF7tgtmdP6fhuFzgv/dFrvsQgUddklCKDBA4s?=
 =?us-ascii?Q?jqOl/o52JZy+FNCcfLbr3es284LeNXQ2W2eIZHGRJXEqVSllxfPJyi5A3Hyq?=
 =?us-ascii?Q?onjk+AwX95fz4du0G3YQm7e1GgX/5ZuA8QGMjC1R2VCQVPNK142irWpoUFW8?=
 =?us-ascii?Q?GsH0Hxld3zZK6R0r4GjHNNO1AEvG3SolWcNyV0YV8iVvgrkZ/JfVEm8OufxD?=
 =?us-ascii?Q?k3dfJsF7q971EqqGjLGV6abm/6EGjjiITjNyAh5/VacCiL+ESZyc8l9GIC0/?=
 =?us-ascii?Q?yRFuDk1ug2YGeivarZ4DvZmG6G1HNkkJg5LW1MDe80KdsiknOyuyb0E1ny3H?=
 =?us-ascii?Q?Zx2esfE+Ks+ugpi+p0U3TALOFFhBu6FPVzbxKydHZBDUh3iMBoM8Z5VEnHcW?=
 =?us-ascii?Q?BoynTudoBmG3VkoU6nqBMPnLXSyci3HzSX7a4p8mtS9L2dtKnH9BHp0CifZv?=
 =?us-ascii?Q?EnuzhM3YhyAloSOj5DXFLtrD3phbnKM2lA87OBkGwzYBkbY9o9fa4q9yYBoK?=
 =?us-ascii?Q?k3TsFmvSUIEsSNcfA4AhllDMrTYmhw/YQsHqhtl4qRFBtcO2EtFADClgozv2?=
 =?us-ascii?Q?pCqDlIZIP4HfG7ay3HShOyYMJc/oNrhKEdM4Gh2O3chVfpjhvX6gWnMlXJI+?=
 =?us-ascii?Q?tavU9Df4ehlyNW1zYwmn2urz1WFz+9oed6m37aLlJ/AHBCXZVX/C64fKcEXz?=
 =?us-ascii?Q?vnA2JfCuZqWj4cXhsUiTCegwNpQ9opOVg7aPtSVlNMSncNwC41eyG1KhTvZt?=
 =?us-ascii?Q?Lm+8cwUefWb58Kr5HBlR+36gyqqdzoUrdCtatc4owAe5Dsv6jpOV+CWPCWmg?=
 =?us-ascii?Q?i0oMpQeOwRtYnVUDZ0rLo4zDDMNDkAAu8hNPn+zVhe00oyoxglG2?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9200b0-4b09-4670-df5b-08da28738f87
X-MS-Exchange-CrossTenant-AuthSource: SA0PR01MB6329.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 17:30:02.9803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGWyWsXRbwe4x1GG/eQOzHmUwIpXGoVjj3oyfKCuJ2uRaFAh9RYgXF4YAEPNvoQ2kk4V36nDM0+uPGZWF841EzRbbnkCFhu3hCMeXNN9LjEIZ/qtpY0AlkGvNPJ7vx5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR01MB3642
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some trivial cleanup and add Darren Hart as Ampere Computing's contact for
embargoed hardware issues.

Darren Hart (2):
  Documentation/process: Make groups alphabetical and use tabs
    consistently
  Documentation/process: Add embargoed HW contact for Ampere Computing

 Documentation/process/embargoed-hardware-issues.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.34.1

