Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBFA55D098
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiF0JAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiF0JAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:00:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1BC63A3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:00:33 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25R8BuKP028114;
        Mon, 27 Jun 2022 09:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=7ybi4uuv2UsSkdNGFKxhBjHg13ZgnNx2vnAcPa0TLDk=;
 b=gdKXSh5AJCNeUzLE0CSE5iWcQPI64C3VDbZiwrpqBpJGuFwwJvLCZYrR+Y7q+gv3p2R2
 LKlTZUl89FO7mn9AQZ4We2m8xm4QyFsuk4Me72pFYIKsARAZe96errc9ued2KKT4+91B
 PPKBViYQl/GZ0p/0m9t/o0NwOKmKnLmE3Qbds/6+s+sBNomRl+o1V/hyYQvxpekOCGpy
 FxqkndyKVTRzjtulkdTSPDiSO4ZxydCZVUfo5/aio1+j0osWBdy3n0uqoXlkfPAugVUy
 zghRE7I2LhqYe7MDiHsY1Dbn5l/6kGuXDd2uIc3bGT8ksLb5JRxM5yNeleWZta2Pnp28 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gy8tx1a0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:00:11 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25R8EYFm016389;
        Mon, 27 Jun 2022 09:00:10 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gy8tx19y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:00:10 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25R8opZ9019411;
        Mon, 27 Jun 2022 09:00:08 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3gwt08tkch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jun 2022 09:00:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25R905Qb23003460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 09:00:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2F464C04E;
        Mon, 27 Jun 2022 09:00:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B30C4C046;
        Mon, 27 Jun 2022 09:00:04 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.43.15.159])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 27 Jun 2022 09:00:04 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH] powerpc: perf: Fix refcount leak bug in imc-pmu.c
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220618071353.4059000-1-windhl@126.com>
Date:   Mon, 27 Jun 2022 14:30:01 +0530
Cc:     Michael Ellerman <mpe@ellerman.id.au>, benh@kernel.crashing.org,
        paulus@samba.org, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B61320C-C37F-4B60-BE2B-461722D44742@linux.vnet.ibm.com>
References: <20220618071353.4059000-1-windhl@126.com>
To:     Liang He <windhl@126.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zXsXuV6a2jBqMgCfbfqhXcrLvpQo9LTl
X-Proofpoint-ORIG-GUID: gSeTZLwweVeVvJgGXu_YjN97T9abW9_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-27_06,2022-06-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 clxscore=1011 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206270036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 18-Jun-2022, at 12:43 PM, Liang He <windhl@126.com> wrote:
>=20
> In update_events_in_group(), of_find_node_by_phandle() will return
> a node pointer with refcount incremented. We should use of_node_put()
> in fail path or when it is not used anymore.
>=20
> Signed-off-by: Liang He <windhl@126.com>

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
> arch/powerpc/perf/imc-pmu.c | 10 ++++++++--
> 1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index d7976ab40d38..d517aba94d1b 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -240,8 +240,10 @@ static int update_events_in_group(struct =
device_node *node, struct imc_pmu *pmu)
> 	ct =3D of_get_child_count(pmu_events);
>=20
> 	/* Get the event prefix */
> -	if (of_property_read_string(node, "events-prefix", &prefix))
> +	if (of_property_read_string(node, "events-prefix", &prefix)) {
> +		of_node_put(pmu_events);
> 		return 0;
> +	}
>=20
> 	/* Get a global unit and scale data if available */
> 	if (of_property_read_string(node, "scale", &g_scale))
> @@ -255,8 +257,10 @@ static int update_events_in_group(struct =
device_node *node, struct imc_pmu *pmu)
>=20
> 	/* Allocate memory for the events */
> 	pmu->events =3D kcalloc(ct, sizeof(struct imc_events), =
GFP_KERNEL);
> -	if (!pmu->events)
> +	if (!pmu->events) {
> +		of_node_put(pmu_events);
> 		return -ENOMEM;
> +	}
>=20
> 	ct =3D 0;
> 	/* Parse the events and update the struct */
> @@ -266,6 +270,8 @@ static int update_events_in_group(struct =
device_node *node, struct imc_pmu *pmu)
> 			ct++;
> 	}
>=20
> +	of_node_put(pmu_events);
> +
> 	/* Allocate memory for attribute group */
> 	attr_group =3D kzalloc(sizeof(*attr_group), GFP_KERNEL);
> 	if (!attr_group) {
> --=20
> 2.25.1
>=20

