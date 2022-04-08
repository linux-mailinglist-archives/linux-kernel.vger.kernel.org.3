Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33064F97D8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiDHOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbiDHOUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:20:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87F32350E45
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649427523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dqj6F//n2GaeDZEKW0iyCYuUnbyXalGGnl0TwpnivlQ=;
        b=XCtCiPHZinodqQDy3glyAcnrm+++dbxcTH+mU5brYb5JOzws2dPPM1Y1fOxebmqFMF/aT3
        I3Y0cPWTTt0aChnC5Rar+KD4xnVAyrXPcW6qUaH2paRHeTnUQ0jgykIs75uDgAiBRylpQ0
        nSnPq7k9w9Yit6EIeyIr4Ib25g4zogQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-GiST4J9iN1WRO9KcvNeQow-1; Fri, 08 Apr 2022 10:18:42 -0400
X-MC-Unique: GiST4J9iN1WRO9KcvNeQow-1
Received: by mail-ej1-f69.google.com with SMTP id sb14-20020a1709076d8e00b006e7eb9719b9so4958945ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dqj6F//n2GaeDZEKW0iyCYuUnbyXalGGnl0TwpnivlQ=;
        b=dC78z+H2evjbkFUBUDoVKLqwkCnfdjyYWl07sIWvjAyLbB3Oqsw3XUO8C5puPdDlLh
         zg9jMXMfQdVm8BZogfqzBFTOW0MJ7pBIwiNNVXgznPKQ7fRWuWVt31JlV0EhRv9GpJDK
         YU0iwxufqitjTB0Rj0y797Ds6NHmPzVfiGHg0KN8nnULD8N3Cd0aiWYX5MWI16q5XLVq
         Yw6ZSzk3DmoNv+W3MnSaudQ7KpsvCtnUscGatVw8wuq/hZmZyYqtJVPc3IqiBDzS9ONb
         9sNOWETiGYj5bXfn+3dqJyGl4IWI0KIXEd48UoXu0dBoS+7vzyN7Pi03OFPXKJjtTAo8
         3b+A==
X-Gm-Message-State: AOAM531hhsqfZkqiDnrVt9KI50QWg7k/S+a0zPpQDPLjIGkFXH9zMsf5
        d9GSGLn0cwKapvygHviviIKBBz9VtkpTBLIaMbYkPosbwC6piY0M0B67oWptLnFDIpR7lDzcEpq
        zL/R886X23edQ49hVfIPh5WKu
X-Received: by 2002:a17:906:4e5a:b0:6e8:4f14:dcc6 with SMTP id g26-20020a1709064e5a00b006e84f14dcc6mr3274007ejw.378.1649427520529;
        Fri, 08 Apr 2022 07:18:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOCOFvHo61foMzX7A4+BKy2YI1Wcfu8ng+vn/PmyPdBWgShP60HLzT+87KhD1FkgqVFyBShw==
X-Received: by 2002:a17:906:4e5a:b0:6e8:4f14:dcc6 with SMTP id g26-20020a1709064e5a00b006e84f14dcc6mr3273945ejw.378.1649427519739;
        Fri, 08 Apr 2022 07:18:39 -0700 (PDT)
Received: from [10.39.195.79] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906244800b006e859d92386sm436960ejb.104.2022.04.08.07.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:18:38 -0700 (PDT)
From:   Eelco Chaudron <echaudro@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf scripting python: expose symbol offset and source
 information
Date:   Fri, 08 Apr 2022 16:18:38 +0200
X-Mailer: MailMate (1.14r5883)
Message-ID: <A0B24D47-90A5-41FC-8D24-8C1D3491CB71@redhat.com>
In-Reply-To: <164554263724.752731.14651017093796049736.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
References: <164554263724.752731.14651017093796049736.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22 Feb 2022, at 16:11, Eelco Chaudron wrote:

> This change adds the symbol offset to the data exported for each
> call-chain entry. This can not be calculated from the script and
> only the ip value, and no related mmap information.
>
> In addition, also export the source file and line information, if
> available, to avoid an external lookup if this information is needed.
>
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>

Hi All, was wondering if this patch got lost?

> ---
> v2:
>  - Fixed small code nit
>  - Included new features in auto generated scripts
>
>  .../util/scripting-engines/trace-event-python.c    |   49 ++++++++++++=
+++-----
>  1 file changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/t=
ools/perf/util/scripting-engines/trace-event-python.c
> index e752e1f4a5f0..86a9c8614231 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -392,6 +392,18 @@ static const char *get_dsoname(struct map *map)
>  	return dsoname;
>  }
>
> +static unsigned long get_offset(struct symbol *sym, struct addr_locati=
on *al)
> +{
> +	unsigned long offset;
> +
> +	if (al->addr < sym->end)
> +		offset =3D al->addr - sym->start;
> +	else
> +		offset =3D al->addr - al->map->start - sym->start;
> +
> +	return offset;
> +}
> +
>  static PyObject *python_process_callchain(struct perf_sample *sample,
>  					 struct evsel *evsel,
>  					 struct addr_location *al)
> @@ -443,6 +455,25 @@ static PyObject *python_process_callchain(struct p=
erf_sample *sample,
>  					_PyUnicode_FromStringAndSize(node->ms.sym->name,
>  							node->ms.sym->namelen));
>  			pydict_set_item_string_decref(pyelem, "sym", pysym);
> +
> +			if (node->ms.map) {
> +				struct map *map =3D node->ms.map;
> +				struct addr_location node_al;
> +				unsigned long offset;
> +
> +				node_al.addr =3D map->map_ip(map, node->ip);
> +				node_al.map  =3D map;
> +				offset =3D get_offset(node->ms.sym, &node_al);
> +
> +				pydict_set_item_string_decref(
> +					pyelem, "sym_off",
> +					PyLong_FromUnsignedLongLong(offset));
> +			}
> +			if (node->srcline && strcmp(":0", node->srcline)) {
> +				pydict_set_item_string_decref(
> +					pyelem, "sym_srcline",
> +					_PyUnicode_FromString(node->srcline));
> +			}
>  		}
>
>  		if (node->ms.map) {
> @@ -520,18 +551,6 @@ static PyObject *python_process_brstack(struct per=
f_sample *sample,
>  	return pylist;
>  }
>
> -static unsigned long get_offset(struct symbol *sym, struct addr_locati=
on *al)
> -{
> -	unsigned long offset;
> -
> -	if (al->addr < sym->end)
> -		offset =3D al->addr - sym->start;
> -	else
> -		offset =3D al->addr - al->map->start - sym->start;
> -
> -	return offset;
> -}
> -
>  static int get_symoff(struct symbol *sym, struct addr_location *al,
>  		      bool print_off, char *bf, int size)
>  {
> @@ -2073,7 +2092,11 @@ static int python_generate_script(struct tep_han=
dle *pevent, const char *outfile
>
>  		fprintf(ofp, "\t\tfor node in common_callchain:");
>  		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
> -		fprintf(ofp, "\n\t\t\t\tprint(\"\\t[%%x] %%s\" %% (node['ip'], node[=
'sym']['name']))");
> +		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x] %%s%%s%%s%%s\" %% (");
> +		fprintf(ofp, "\n\t\t\t\t\tnode['ip'], node['sym']['name'],");
> +		fprintf(ofp, "\n\t\t\t\t\t\"+0x{:x}\".format(node['sym_off']) if 'sy=
m_off' in node else \"\",");
> +		fprintf(ofp, "\n\t\t\t\t\t\" ({})\".format(node['dso'])  if 'dso' in=
 node else \"\",");
> +		fprintf(ofp, "\n\t\t\t\t\t\" \" + node['sym_srcline'] if 'sym_srclin=
e' in node else \"\"))");
>  		fprintf(ofp, "\n\t\t\telse:");
>  		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
>  		fprintf(ofp, "\t\tprint()\n\n");

