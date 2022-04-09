Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E48C4FA955
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242511AbiDIPoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiDIPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:44:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEE6F7B;
        Sat,  9 Apr 2022 08:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3100E60B30;
        Sat,  9 Apr 2022 15:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65700C385A0;
        Sat,  9 Apr 2022 15:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649518956;
        bh=+rpBJT4Nr106UTu9CJknKUAZU0Kx2GW1NeXF+/AE6HY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kuxzc3kC1dZwLLo2+vdIL998HYmOT5BBZtZowHF9rvw71FUvOlGCts+gX/kuWU4FF
         ULfTYkDCZ/yzzchFwRbUEjY5x6+YNia4NrCbAbG7wSRMaGjqSTjB4Owsiy+3lEATRH
         ldeSUCDsu9fOlhjOh9rH6a9mE3qezxAXcO7Z0xX6amHSbT283xh/U9/NqxLUXwY/8G
         2mxForlA13tpnOSK2VlIz9UThjb25/AAKH02vmJct/5sXP3xHeP+1LBic0abMKfsp4
         MFZGJPUvZZn+lChrHohxWv6bNuAI6Xl2SKTN1gZ+B8Zohv3oQXt3CNJOur/02pyMGJ
         6Je4GwbBUKq1Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4FE7640407; Sat,  9 Apr 2022 12:42:33 -0300 (-03)
Date:   Sat, 9 Apr 2022 12:42:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Eelco Chaudron <echaudro@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf scripting python: expose symbol offset and
 source information
Message-ID: <YlGpafg8aYyAylpC@kernel.org>
References: <164554263724.752731.14651017093796049736.stgit@wsfd-netdev64.ntdv.lab.eng.bos.redhat.com>
 <A0B24D47-90A5-41FC-8D24-8C1D3491CB71@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A0B24D47-90A5-41FC-8D24-8C1D3491CB71@redhat.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Apr 08, 2022 at 04:18:38PM +0200, Eelco Chaudron escreveu:
> 
> 
> On 22 Feb 2022, at 16:11, Eelco Chaudron wrote:
> 
> > This change adds the symbol offset to the data exported for each
> > call-chain entry. This can not be calculated from the script and
> > only the ip value, and no related mmap information.
> >
> > In addition, also export the source file and line information, if
> > available, to avoid an external lookup if this information is needed.
> >
> > Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> 
> Hi All, was wondering if this patch got lost?

Applied now to perf/core, heading to 5.19,

- Arnaldo
 
> > ---
> > v2:
> >  - Fixed small code nit
> >  - Included new features in auto generated scripts
> >
> >  .../util/scripting-engines/trace-event-python.c    |   49 +++++++++++++++-----
> >  1 file changed, 36 insertions(+), 13 deletions(-)
> >
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index e752e1f4a5f0..86a9c8614231 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -392,6 +392,18 @@ static const char *get_dsoname(struct map *map)
> >  	return dsoname;
> >  }
> >
> > +static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
> > +{
> > +	unsigned long offset;
> > +
> > +	if (al->addr < sym->end)
> > +		offset = al->addr - sym->start;
> > +	else
> > +		offset = al->addr - al->map->start - sym->start;
> > +
> > +	return offset;
> > +}
> > +
> >  static PyObject *python_process_callchain(struct perf_sample *sample,
> >  					 struct evsel *evsel,
> >  					 struct addr_location *al)
> > @@ -443,6 +455,25 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
> >  					_PyUnicode_FromStringAndSize(node->ms.sym->name,
> >  							node->ms.sym->namelen));
> >  			pydict_set_item_string_decref(pyelem, "sym", pysym);
> > +
> > +			if (node->ms.map) {
> > +				struct map *map = node->ms.map;
> > +				struct addr_location node_al;
> > +				unsigned long offset;
> > +
> > +				node_al.addr = map->map_ip(map, node->ip);
> > +				node_al.map  = map;
> > +				offset = get_offset(node->ms.sym, &node_al);
> > +
> > +				pydict_set_item_string_decref(
> > +					pyelem, "sym_off",
> > +					PyLong_FromUnsignedLongLong(offset));
> > +			}
> > +			if (node->srcline && strcmp(":0", node->srcline)) {
> > +				pydict_set_item_string_decref(
> > +					pyelem, "sym_srcline",
> > +					_PyUnicode_FromString(node->srcline));
> > +			}
> >  		}
> >
> >  		if (node->ms.map) {
> > @@ -520,18 +551,6 @@ static PyObject *python_process_brstack(struct perf_sample *sample,
> >  	return pylist;
> >  }
> >
> > -static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
> > -{
> > -	unsigned long offset;
> > -
> > -	if (al->addr < sym->end)
> > -		offset = al->addr - sym->start;
> > -	else
> > -		offset = al->addr - al->map->start - sym->start;
> > -
> > -	return offset;
> > -}
> > -
> >  static int get_symoff(struct symbol *sym, struct addr_location *al,
> >  		      bool print_off, char *bf, int size)
> >  {
> > @@ -2073,7 +2092,11 @@ static int python_generate_script(struct tep_handle *pevent, const char *outfile
> >
> >  		fprintf(ofp, "\t\tfor node in common_callchain:");
> >  		fprintf(ofp, "\n\t\t\tif 'sym' in node:");
> > -		fprintf(ofp, "\n\t\t\t\tprint(\"\\t[%%x] %%s\" %% (node['ip'], node['sym']['name']))");
> > +		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x] %%s%%s%%s%%s\" %% (");
> > +		fprintf(ofp, "\n\t\t\t\t\tnode['ip'], node['sym']['name'],");
> > +		fprintf(ofp, "\n\t\t\t\t\t\"+0x{:x}\".format(node['sym_off']) if 'sym_off' in node else \"\",");
> > +		fprintf(ofp, "\n\t\t\t\t\t\" ({})\".format(node['dso'])  if 'dso' in node else \"\",");
> > +		fprintf(ofp, "\n\t\t\t\t\t\" \" + node['sym_srcline'] if 'sym_srcline' in node else \"\"))");
> >  		fprintf(ofp, "\n\t\t\telse:");
> >  		fprintf(ofp, "\n\t\t\t\tprint(\"\t[%%x]\" %% (node['ip']))\n\n");
> >  		fprintf(ofp, "\t\tprint()\n\n");

-- 

- Arnaldo
