Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5DD514545
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356471AbiD2JZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbiD2JZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:25:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8241AC44E5;
        Fri, 29 Apr 2022 02:21:55 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23T8g2ou016650;
        Fri, 29 Apr 2022 09:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=XGz74g6r7bfay3TJtUAylO5tzHA8LxeOJ7nK0ZubZ+I=;
 b=orCpsqrRDRP49eNUArYYxr2MXzRF6K/BWxOsYpnLw+0Mk3n7ytaxHKcU2kx0SabfOMNy
 bbnaNafaNQZUHIErkrUBz8pTqCUEx4LUGA9ShfkbSNK0rAzo7Bd9FuFT7Gm8F7i5GWkP
 1rv+BlI5+7OHzoNDH/BV0XxOyC9EPTYYep+dZIyojkOeQ3D7uoFBpS+0hnYB7JFv7hIJ
 gMbRevdO7z0TvXi4sia4rh6qGLtfNOCOJ8uUuyyVRPEN1lcgBQ1aDpRgfg0Gfb9lbjIq
 l2Et3WSXur7e8IwhZWnmPJsQEW97J1CD2yIp5XNPoHmm48xwo4IQpvRhDPtk0CSpasRi Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fr27gunju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 09:21:40 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 23T9CW4Z012831;
        Fri, 29 Apr 2022 09:21:39 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fr27gunjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 09:21:39 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23T9DWw2023982;
        Fri, 29 Apr 2022 09:21:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3fm8qj8vm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Apr 2022 09:21:37 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23T9LZsn38600970
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 09:21:35 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358684C040;
        Fri, 29 Apr 2022 09:21:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C811A4C046;
        Fri, 29 Apr 2022 09:21:29 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.66.49])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 29 Apr 2022 09:21:29 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 1/2] perf bench: Fix two numa NDEBUG warnings
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20220428202912.1056444-1-irogers@google.com>
Date:   Fri, 29 Apr 2022 14:51:25 +0530
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FDBE8FEC-CC4B-43C2-B2AA-3ECCFF95A98E@linux.vnet.ibm.com>
References: <20220428202912.1056444-1-irogers@google.com>
To:     Ian Rogers <irogers@google.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 76Ze89AhoPN_sVKInyOkuaQ5lRaLzxjG
X-Proofpoint-GUID: vlndh-ewUzu4tkp6VCirMT1Pf2DSTL1z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-29_05,2022-04-28_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 29-Apr-2022, at 1:59 AM, Ian Rogers <irogers@google.com> wrote:
>=20
> BUG_ON is a no-op if NDEBUG is defined, otherwise it is an assert.
> Compiling with NDEBUG yields:
>=20
> bench/numa.c: In function =E2=80=98bind_to_cpu=E2=80=99:
> bench/numa.c:314:1: error: control reaches end of non-void function =
[-Werror=3Dreturn-type]
>  314 | }
>      | ^
> bench/numa.c: In function =E2=80=98bind_to_node=E2=80=99:
> bench/numa.c:367:1: error: control reaches end of non-void function =
[-Werror=3Dreturn-type]
>  367 | }
>      | ^
>=20
> Add return statements to cover this case.

Looks fine to me

Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Thanks
Athira
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> tools/perf/bench/numa.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 44e1f8a44087..d5289fa58a4f 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -311,6 +311,7 @@ static cpu_set_t *bind_to_cpu(int target_cpu)
>=20
> 	/* BUG_ON due to failure in allocation of orig_mask/mask */
> 	BUG_ON(-1);
> +	return NULL;
> }
>=20
> static cpu_set_t *bind_to_node(int target_node)
> @@ -364,6 +365,7 @@ static cpu_set_t *bind_to_node(int target_node)
>=20
> 	/* BUG_ON due to failure in allocation of orig_mask/mask */
> 	BUG_ON(-1);
> +	return NULL;
> }
>=20
> static void bind_to_cpumask(cpu_set_t *mask)
> --=20
> 2.36.0.464.gb9c8b46e94-goog
>=20

