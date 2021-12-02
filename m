Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EA546678B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359078AbhLBQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:07:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242221AbhLBQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:07:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2FHMK4009200;
        Thu, 2 Dec 2021 16:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to; s=pp1;
 bh=8a9oXbGzR78DoslxbXE4jxGAjt67YTQ0reW4bF4Hevs=;
 b=Qj5hcRxi5axETJ9TcrTOc9/W00LyNOtel0+c9rNdi1P0PkcwSAkdF31rz3ZG4O01TmJ9
 +WA0sNhfL+l2GayVHeQ9dT0HAQv6bTCjXnzYiKbXdVTCY7mNoZ2Jp845QjYLMTIrX7zQ
 MtJCIBJOfUmSF8zVWJ1q6ClUFPRdK0gIgVtMnp3MR5ty0Bi416Lt9XIR5yYhFuaXe6CR
 sC8IIl+m3T+PPaTSfc2coYyys7VyMGddwSS84oqEpmNSASYOULomW0/ZFnBtODys2zNy
 bt4y4m9kaJXk1UebKq9GI41X++pAb7u3XcTqumehmfYt+im0la0/giEpV0mG/DSZx9QL IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq0nfh44r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:03:45 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B2FJdA0016004;
        Thu, 2 Dec 2021 16:03:44 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq0nfh440-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:03:44 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B2G3SQZ002918;
        Thu, 2 Dec 2021 16:03:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 3ckcaabrw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 16:03:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B2G3dlQ24903936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Dec 2021 16:03:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ED2652059;
        Thu,  2 Dec 2021 16:03:39 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.211.114.96])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 7E2CB52067;
        Thu,  2 Dec 2021 16:03:32 +0000 (GMT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v1 2/4] perf script: Add "struct machine" parameter to
 process_event callback
From:   Athira Rajeev <atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20211201123334.679131-3-german.gomez@arm.com>
Date:   Thu, 2 Dec 2021 21:33:27 +0530
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6A3A8F3-9946-44FE-A70F-42977C6F38A1@linux.vnet.ibm.com>
References: <20211201123334.679131-1-german.gomez@arm.com>
 <20211201123334.679131-3-german.gomez@arm.com>
To:     German Gomez <german.gomez@arm.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3CMRHBoEOFgCLvdPBjbwdGqw0tdvwfdq
X-Proofpoint-GUID: 5I37IjOv4eevDAaMX3wVdZbi9xQEN6p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_10,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 impostorscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 01-Dec-2021, at 6:03 PM, German Gomez <german.gomez@arm.com> wrote:
>=20
> Include a "struct machine*" parameter to the process_event callback in
> the scripting layer. This will allow access to the perf_env from =
within
> this callback.
>=20
> Followup patches will build on top of this to report the correct name =
of
> the registers in a perf.data file, consistently with the architecture
> the file was recorded in.
>=20
> Signed-off-by: German Gomez <german.gomez@arm.com>
> ---
> tools/perf/builtin-script.c                   |  2 +-
> .../util/scripting-engines/trace-event-perl.c |  3 ++-
> .../scripting-engines/trace-event-python.c    | 23 +++++++++++--------
> tools/perf/util/trace-event-scripting.c       |  3 ++-
> tools/perf/util/trace-event.h                 |  3 ++-
> 5 files changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 9434367af..711132f0b 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2256,7 +2256,7 @@ static int process_sample_event(struct perf_tool =
*tool,
> 				thread__resolve(al.thread, &addr_al, =
sample);
> 			addr_al_ptr =3D &addr_al;
> 		}
> -		scripting_ops->process_event(event, sample, evsel, &al, =
addr_al_ptr);
> +		scripting_ops->process_event(event, sample, evsel, &al, =
addr_al_ptr, machine);

Hi,

Looks like the patch is using =E2=80=9Cmachine=E2=80=9D to allow access =
to perf_env__arch and there by to get the =E2=80=9Carch=E2=80=9D value.
But can we use from evsel, like  "perf_env__arch(evsel__env(evsel))=E2=80=9D=
 to get arch value instead of including new parameter for =E2=80=9Cstruct =
machine=E2=80=9D ?

Thanks
Athira=20
> 	} else {
> 		process_event(scr, sample, evsel, &al, &addr_al, =
machine);
> 	}
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c =
b/tools/perf/util/scripting-engines/trace-event-perl.c
> index 32a721b3e..6017c4660 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -454,7 +454,8 @@ static void perl_process_event(union perf_event =
*event,
> 			       struct perf_sample *sample,
> 			       struct evsel *evsel,
> 			       struct addr_location *al,
> -			       struct addr_location *addr_al)
> +			       struct addr_location *addr_al,
> +			       struct machine *machine __maybe_unused)
> {
> 	scripting_context__update(scripting_context, event, sample, =
evsel, al, addr_al);
> 	perl_process_tracepoint(sample, evsel, al);
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c =
b/tools/perf/util/scripting-engines/trace-event-python.c
> index c0c010350..e164f8d00 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -708,7 +708,8 @@ static void regs_map(struct regs_dump *regs, =
uint64_t mask, char *bf, int size)
>=20
> static void set_regs_in_dict(PyObject *dict,
> 			     struct perf_sample *sample,
> -			     struct evsel *evsel)
> +			     struct evsel *evsel,
> +			     struct machine *machine __maybe_unused)
> {
> 	struct perf_event_attr *attr =3D &evsel->core.attr;
>=20
> @@ -776,6 +777,7 @@ static PyObject *get_perf_sample_dict(struct =
perf_sample *sample,
> 					 struct evsel *evsel,
> 					 struct addr_location *al,
> 					 struct addr_location *addr_al,
> +					 struct machine *machine,
> 					 PyObject *callchain)
> {
> 	PyObject *dict, *dict_sample, *brstack, *brstacksym;
> @@ -849,7 +851,7 @@ static PyObject *get_perf_sample_dict(struct =
perf_sample *sample,
> 			PyLong_FromUnsignedLongLong(sample->cyc_cnt));
> 	}
>=20
> -	set_regs_in_dict(dict, sample, evsel);
> +	set_regs_in_dict(dict, sample, evsel, machine);
>=20
> 	return dict;
> }
> @@ -857,7 +859,8 @@ static PyObject *get_perf_sample_dict(struct =
perf_sample *sample,
> static void python_process_tracepoint(struct perf_sample *sample,
> 				      struct evsel *evsel,
> 				      struct addr_location *al,
> -				      struct addr_location *addr_al)
> +				      struct addr_location *addr_al,
> +				      struct machine *machine)
> {
> 	struct tep_event *event =3D evsel->tp_format;
> 	PyObject *handler, *context, *t, *obj =3D NULL, *callchain;
> @@ -964,7 +967,7 @@ static void python_process_tracepoint(struct =
perf_sample *sample,
> 		PyTuple_SetItem(t, n++, dict);
>=20
> 	if (get_argument_count(handler) =3D=3D (int) n + 1) {
> -		all_entries_dict =3D get_perf_sample_dict(sample, evsel, =
al, addr_al,
> +		all_entries_dict =3D get_perf_sample_dict(sample, evsel, =
al, addr_al, machine,
> 			callchain);
> 		PyTuple_SetItem(t, n++,	all_entries_dict);
> 	} else {
> @@ -1366,7 +1369,8 @@ static int python_process_call_return(struct =
call_return *cr, u64 *parent_db_id,
> static void python_process_general_event(struct perf_sample *sample,
> 					 struct evsel *evsel,
> 					 struct addr_location *al,
> -					 struct addr_location *addr_al)
> +					 struct addr_location *addr_al,
> +					 struct machine *machine)
> {
> 	PyObject *handler, *t, *dict, *callchain;
> 	static char handler_name[64];
> @@ -1388,7 +1392,7 @@ static void python_process_general_event(struct =
perf_sample *sample,
>=20
> 	/* ip unwinding */
> 	callchain =3D python_process_callchain(sample, evsel, al);
> -	dict =3D get_perf_sample_dict(sample, evsel, al, addr_al, =
callchain);
> +	dict =3D get_perf_sample_dict(sample, evsel, al, addr_al, =
machine, callchain);
>=20
> 	PyTuple_SetItem(t, n++, dict);
> 	if (_PyTuple_Resize(&t, n) =3D=3D -1)
> @@ -1403,7 +1407,8 @@ static void python_process_event(union =
perf_event *event,
> 				 struct perf_sample *sample,
> 				 struct evsel *evsel,
> 				 struct addr_location *al,
> -				 struct addr_location *addr_al)
> +				 struct addr_location *addr_al,
> +				 struct machine *machine)
> {
> 	struct tables *tables =3D &tables_global;
>=20
> @@ -1411,14 +1416,14 @@ static void python_process_event(union =
perf_event *event,
>=20
> 	switch (evsel->core.attr.type) {
> 	case PERF_TYPE_TRACEPOINT:
> -		python_process_tracepoint(sample, evsel, al, addr_al);
> +		python_process_tracepoint(sample, evsel, al, addr_al, =
machine);
> 		break;
> 	/* Reserve for future process_hw/sw/raw APIs */
> 	default:
> 		if (tables->db_export_mode)
> 			db_export__sample(&tables->dbe, event, sample, =
evsel, al, addr_al);
> 		else
> -			python_process_general_event(sample, evsel, al, =
addr_al);
> +			python_process_general_event(sample, evsel, al, =
addr_al, machine);
> 	}
> }
>=20
> diff --git a/tools/perf/util/trace-event-scripting.c =
b/tools/perf/util/trace-event-scripting.c
> index 7172ca052..089a2c905 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -51,7 +51,8 @@ static void process_event_unsupported(union =
perf_event *event __maybe_unused,
> 				      struct perf_sample *sample =
__maybe_unused,
> 				      struct evsel *evsel =
__maybe_unused,
> 				      struct addr_location *al =
__maybe_unused,
> -				      struct addr_location *addr_al =
__maybe_unused)
> +				      struct addr_location *addr_al =
__maybe_unused,
> +				      struct machine *machine =
__maybe_unused)
> {
> }
>=20
> diff --git a/tools/perf/util/trace-event.h =
b/tools/perf/util/trace-event.h
> index 640981105..6f5b1a6d5 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -81,7 +81,8 @@ struct scripting_ops {
> 			       struct perf_sample *sample,
> 			       struct evsel *evsel,
> 			       struct addr_location *al,
> -			       struct addr_location *addr_al);
> +			       struct addr_location *addr_al,
> +			       struct machine *machine);
> 	void (*process_switch)(union perf_event *event,
> 			       struct perf_sample *sample,
> 			       struct machine *machine);
> --=20
> 2.25.1
>=20
>=20

