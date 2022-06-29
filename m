Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB655FBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiF2JSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiF2JS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:18:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AFA35DD7;
        Wed, 29 Jun 2022 02:18:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so31290322ejb.6;
        Wed, 29 Jun 2022 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YQ2liDNfsWzTdaQwT5Zj1QzIYCnNrLNtOJI6KLhDBKA=;
        b=cS85G4x8XensQbCOxFzETVRXSRBSv/AvQ5qcRtF5jMSMI2VGYXD1IoGZwNJ2UJBTcO
         vQUyqGT8oowDPQTzVzQITSBRRbpr4Q9s8EU6g2qfbKRH37fsrpGqOZNDAqbFCu3Pfepk
         OobT+L6TDen01+gEvfnDI55gbyDEQNXkDFNg8SsEFKFm0rEfOca96PY1yKgegmpOV1GK
         gq27/70qdzvYe0GCuoS9zHAtsG634anILAGUp2NG5t28iyle4M0eFECAIwoPPlwBw2sG
         RuK/WbDLcDfiCavrbeiMesR5KBNnJYVHQ38qnGbBK+cYutsVMKTVTNMmx2Ud8pocgWC8
         aOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQ2liDNfsWzTdaQwT5Zj1QzIYCnNrLNtOJI6KLhDBKA=;
        b=XVdXyyvE73w760XHD74BJn3CzABXeCaLtIZgllczL6GQRLpixkBZRAggC9X7k076HN
         USfD2r/v9EpA7+2Ey+EZrvLHE/FCBSLRkJ1BFjOpAyZuKkeViWvm2UbcJ5Dv0GtRwbQI
         ShVpnIG0CwtthfG1PPxKbkHsFq8oL9rEO9I8ORi5vzTkUBz6ZevpWPjsf0Lm08v6cjcg
         ka8nq9qDjCMHlVcSkXfJibJZ7mEJ4OhSnNpVz1z/TlUHweGTE8TmP55V/MoC6nv8ArPy
         PEsau8tIZa1vhroKHoX9VrNLz7y4RwMDWgbcEK6ELAjuMIKaqETFLvhmzTFzP92VZbNO
         w7TA==
X-Gm-Message-State: AJIora/dhNEQKyU6mw68T/nREvfgFVSB3f8cRVocEAGDEbT71dt8uY8U
        cORIRV90mEJ2+DydY7+6rZQ=
X-Google-Smtp-Source: AGRyM1uW6oaPhhOkEurR07OoPrbe8D54kuROy2UN9EmmwiM3oCqkvsBvgpYMJxhDGd03cppewiKyOw==
X-Received: by 2002:a17:907:6d13:b0:726:44bd:436d with SMTP id sa19-20020a1709076d1300b0072644bd436dmr2305589ejc.167.1656494305569;
        Wed, 29 Jun 2022 02:18:25 -0700 (PDT)
Received: from krava (net-109-116-206-47.cust.vodafonedsl.it. [109.116.206.47])
        by smtp.gmail.com with ESMTPSA id v5-20020a170906338500b006fed85c1a8fsm7519916eja.202.2022.06.29.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:18:25 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 29 Jun 2022 11:18:21 +0200
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        German Gomez <german.gomez@arm.com>,
        Colin Ian King <colin.king@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 4/6] perf cpumap: Fix alignment for masks in event
 encoding
Message-ID: <YrwY3SP+jsTwrRBw@krava>
References: <20220614143353.1559597-1-irogers@google.com>
 <20220614143353.1559597-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614143353.1559597-5-irogers@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 07:33:51AM -0700, Ian Rogers wrote:
> A mask encoding of a cpu map is laid out as:
>   u16 nr
>   u16 long_size
>   unsigned long mask[];
> However, the mask may be 8-byte aligned meaning there is a 4-byte pad
> after long_size. This means 32-bit and 64-bit builds see the mask as
> being at different offsets. On top of this the structure is in the byte
> data[] encoded as:
>   u16 type
>   char data[]
> This means the mask's struct isn't the required 4 or 8 byte aligned, but
> is offset by 2. Consequently the long reads and writes are causing
> undefined behavior as the alignment is broken.
> 
> Fix the mask struct by creating explicit 32 and 64-bit variants, use a
> union to avoid data[] and casts; the struct must be packed so the
> layout matches the existing perf.data layout. Taking an address of a
> member of a packed struct breaks alignment so pass the packed
> perf_record_cpu_map_data to functions, so they can access variables with
> the right alignment.
> 
> As the 64-bit version has 4 bytes of padding, optimizing writing to only
> write the 32-bit version.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

SNIP

>  struct perf_record_cpu_map {
> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> index f94929ebb54b..7ea150cdc137 100644
> --- a/tools/perf/tests/cpumap.c
> +++ b/tools/perf/tests/cpumap.c
> @@ -17,21 +17,23 @@ static int process_event_mask(struct perf_tool *tool __maybe_unused,
>  			 struct machine *machine __maybe_unused)
>  {
>  	struct perf_record_cpu_map *map_event = &event->cpu_map;
> -	struct perf_record_record_cpu_map *mask;
>  	struct perf_record_cpu_map_data *data;
>  	struct perf_cpu_map *map;
>  	int i;
> +	unsigned int long_size;
>  
>  	data = &map_event->data;
>  
>  	TEST_ASSERT_VAL("wrong type", data->type == PERF_CPU_MAP__MASK);
>  
> -	mask = (struct perf_record_record_cpu_map *)data->data;
> +	long_size = data->mask32_data.long_size;
>  
> -	TEST_ASSERT_VAL("wrong nr",   mask->nr == 1);
> +	TEST_ASSERT_VAL("wrong long_size", long_size == 4 || long_size == 8);

should we check here just for long_size == 4 ?

SNIP

> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 12b2243222b0..ae43fb88f444 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -22,54 +22,102 @@ static int max_node_num;
>   */
>  static int *cpunode_map;
>  
> -static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
> +bool perf_record_cpu_map_data__test_bit(int i,
> +					const struct perf_record_cpu_map_data *data)
> +{
> +	int bit_word32 = i / 32;
> +	__u32 bit_mask32 = 1U << (i & 31);
> +	int bit_word64 = i / 64;
> +	__u64 bit_mask64 = ((__u64)1) << (i & 63);
> +
> +	return (data->mask32_data.long_size == 4)
> +		? (bit_word32 < data->mask32_data.nr) &&
> +		(data->mask32_data.mask[bit_word32] & bit_mask32) != 0
> +		: (bit_word64 < data->mask64_data.nr) &&
> +		(data->mask64_data.mask[bit_word64] & bit_mask64) != 0;
> +}
> +
> +/* Read ith mask value from data into the given 64-bit sized bitmap */
> +static void perf_record_cpu_map_data__read_one_mask(const struct perf_record_cpu_map_data *data,
> +						    int i, unsigned long *bitmap)
> +{
> +#if __SIZEOF_LONG__ == 8
> +	if (data->mask32_data.long_size == 4)
> +		bitmap[0] = data->mask32_data.mask[i];
> +	else
> +		bitmap[0] = data->mask64_data.mask[i];
> +#else
> +	if (data->mask32_data.long_size == 4) {
> +		bitmap[0] = data->mask32_data.mask[i];
> +		bitmap[1] = 0;
> +	} else {
> +#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> +		bitmap[0] = (unsigned long)(data->mask64_data.mask[i] >> 32);
> +		bitmap[1] = (unsigned long)data->mask64_data.mask[i];
> +#else
> +		bitmap[0] = (unsigned long)data->mask64_data.mask[i];
> +		bitmap[1] = (unsigned long)(data->mask64_data.mask[i] >> 32);
> +#endif

should this be taken care of earlier by perf_event__cpu_map_swap ?


> +	}
> +#endif
> +}
> +static struct perf_cpu_map *cpu_map__from_entries(const struct perf_record_cpu_map_data *data)
>  {
>  	struct perf_cpu_map *map;
>  
> -	map = perf_cpu_map__empty_new(cpus->nr);
> +	map = perf_cpu_map__empty_new(data->cpus_data.nr);
>  	if (map) {
>  		unsigned i;
>  
> -		for (i = 0; i < cpus->nr; i++) {
> +		for (i = 0; i < data->cpus_data.nr; i++) {
>  			/*
>  			 * Special treatment for -1, which is not real cpu number,
>  			 * and we need to use (int) -1 to initialize map[i],
>  			 * otherwise it would become 65535.
>  			 */
> -			if (cpus->cpu[i] == (u16) -1)
> +			if (data->cpus_data.cpu[i] == (u16) -1)
>  				map->map[i].cpu = -1;
>  			else
> -				map->map[i].cpu = (int) cpus->cpu[i];
> +				map->map[i].cpu = (int) data->cpus_data.cpu[i];
>  		}
>  	}
>  
>  	return map;
>  }
>  
> -static struct perf_cpu_map *cpu_map__from_mask(struct perf_record_record_cpu_map *mask)
> +static struct perf_cpu_map *cpu_map__from_mask(const struct perf_record_cpu_map_data *data)
>  {
> +	DECLARE_BITMAP(local_copy, 64);
> +	int weight = 0, mask_nr = data->mask32_data.nr;
>  	struct perf_cpu_map *map;
> -	int nr, nbits = mask->nr * mask->long_size * BITS_PER_BYTE;
>  
> -	nr = bitmap_weight(mask->mask, nbits);
> +	for (int i = 0; i < mask_nr; i++) {
> +		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
> +		weight += bitmap_weight(local_copy, 64);
> +	}
> +
> +	map = perf_cpu_map__empty_new(weight);
> +	if (!map)
> +		return NULL;
>  
> -	map = perf_cpu_map__empty_new(nr);
> -	if (map) {
> -		int cpu, i = 0;
> +	for (int i = 0, j = 0; i < mask_nr; i++) {
> +		int cpus_per_i = (i * data->mask32_data.long_size  * BITS_PER_BYTE);
> +		int cpu;
>  
> -		for_each_set_bit(cpu, mask->mask, nbits)
> -			map->map[i++].cpu = cpu;
> +		perf_record_cpu_map_data__read_one_mask(data, i, local_copy);
> +		for_each_set_bit(cpu, local_copy, 64)
> +			map->map[j++].cpu = cpu + cpus_per_i;
>  	}
>  	return map;
>  
>  }
>  
> -struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data)
> +struct perf_cpu_map *cpu_map__new_data(const struct perf_record_cpu_map_data *data)
>  {
>  	if (data->type == PERF_CPU_MAP__CPUS)
> -		return cpu_map__from_entries((struct cpu_map_entries *)data->data);
> +		return cpu_map__from_entries(data);
>  	else
> -		return cpu_map__from_mask((struct perf_record_record_cpu_map *)data->data);
> +		return cpu_map__from_mask(data);
>  }
>  
>  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp)
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 703ae6d3386e..fa8a5acdcae1 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -37,9 +37,11 @@ struct cpu_aggr_map {
>  
>  struct perf_record_cpu_map_data;
>  
> +bool perf_record_cpu_map_data__test_bit(int i, const struct perf_record_cpu_map_data *data);
> +
>  struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
>  
> -struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
> +struct perf_cpu_map *cpu_map__new_data(const struct perf_record_cpu_map_data *data);
>  size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size_t size);
>  size_t cpu_map__fprintf(struct perf_cpu_map *map, FILE *fp);
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 0aa818977d2b..d52a39ba48e3 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -914,30 +914,30 @@ static void perf_event__cpu_map_swap(union perf_event *event,
>  				     bool sample_id_all __maybe_unused)
>  {
>  	struct perf_record_cpu_map_data *data = &event->cpu_map.data;
> -	struct cpu_map_entries *cpus;
> -	struct perf_record_record_cpu_map *mask;
> -	unsigned i;
>  
>  	data->type = bswap_16(data->type);
>  
>  	switch (data->type) {
>  	case PERF_CPU_MAP__CPUS:
> -		cpus = (struct cpu_map_entries *)data->data;
> -
> -		cpus->nr = bswap_16(cpus->nr);
> +		data->cpus_data.nr = bswap_16(data->cpus_data.nr);
>  
> -		for (i = 0; i < cpus->nr; i++)
> -			cpus->cpu[i] = bswap_16(cpus->cpu[i]);
> +		for (unsigned i = 0; i < data->cpus_data.nr; i++)
> +			data->cpus_data.cpu[i] = bswap_16(data->cpus_data.cpu[i]);
>  		break;
>  	case PERF_CPU_MAP__MASK:
> -		mask = (struct perf_record_record_cpu_map *)data->data;
> -
> -		mask->nr = bswap_16(mask->nr);
> -		mask->long_size = bswap_16(mask->long_size);
> +		data->mask32_data.long_size = bswap_16(data->mask32_data.long_size);
>  
> -		switch (mask->long_size) {
> -		case 4: mem_bswap_32(&mask->mask, mask->nr); break;
> -		case 8: mem_bswap_64(&mask->mask, mask->nr); break;
> +		switch (data->mask32_data.long_size) {
> +		case 4:
> +			data->mask32_data.nr = bswap_16(data->mask32_data.nr);
> +			for (unsigned i = 0; i < data->mask32_data.nr; i++)
> +				data->mask32_data.mask[i] = bswap_32(data->mask32_data.mask[i]);
> +			break;

why not use the mem_bswap_* functions?

looks like we never swap it completely, because we passed
mask->nr where should be the size

> +		case 8:
> +			data->mask64_data.nr = bswap_16(data->mask64_data.nr);
> +			for (unsigned i = 0; i < data->mask64_data.nr; i++)
> +				data->mask64_data.mask[i] = bswap_64(data->mask64_data.mask[i]);
> +			break;
>  		default:
>  			pr_err("cpu_map swap: unsupported long size\n");
>  		}
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index 0d87df20ec44..4fa7d0d7dbcf 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1183,27 +1183,33 @@ int perf_event__synthesize_thread_map2(struct perf_tool *tool,
>  	return err;
>  }
>  
> -static void synthesize_cpus(struct cpu_map_entries *cpus,
> +static void synthesize_cpus(struct perf_record_cpu_map_data *data,
>  			    const struct perf_cpu_map *map)
>  {
>  	int i, map_nr = perf_cpu_map__nr(map);
>  
> -	cpus->nr = map_nr;
> +	data->cpus_data.nr = map_nr;
>  
>  	for (i = 0; i < map_nr; i++)
> -		cpus->cpu[i] = perf_cpu_map__cpu(map, i).cpu;
> +		data->cpus_data.cpu[i] = perf_cpu_map__cpu(map, i).cpu;
>  }
>  
> -static void synthesize_mask(struct perf_record_record_cpu_map *mask,
> +static void synthesize_mask(struct perf_record_cpu_map_data *data,
>  			    const struct perf_cpu_map *map, int max)
>  {
> -	int i;
> +	int idx;
> +	struct perf_cpu cpu;
> +
> +	/* Due to padding, the 4bytes per entry mask variant is always smaller. */
> +	data->mask32_data.nr = BITS_TO_U32(max);
> +	data->mask32_data.long_size = 4;

ok, so we go always with 32 bit version

>  
> -	mask->nr = BITS_TO_LONGS(max);
> -	mask->long_size = sizeof(long);
> +	perf_cpu_map__for_each_cpu(cpu, idx, map) {
> +		int bit_word = cpu.cpu / 32;
> +		__u32 bit_mask = 1U << (cpu.cpu & 31);

set_bit uses (nr % 32), but I guess it does not matter


jirka

>  
> -	for (i = 0; i < perf_cpu_map__nr(map); i++)
> -		set_bit(perf_cpu_map__cpu(map, i).cpu, mask->mask);
> +		data->mask32_data.mask[bit_word] |= bit_mask;
> +	}
>  }
>  
>  static size_t cpus_size(const struct perf_cpu_map *map)
> @@ -1214,7 +1220,7 @@ static size_t cpus_size(const struct perf_cpu_map *map)
>  static size_t mask_size(const struct perf_cpu_map *map, int *max)
>  {
>  	*max = perf_cpu_map__max(map).cpu;
> -	return sizeof(struct perf_record_record_cpu_map) + BITS_TO_LONGS(*max) * sizeof(long);
> +	return sizeof(struct perf_record_mask_cpu_map32) + BITS_TO_U32(*max) * sizeof(__u32);
>  }
>  
>  static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
> @@ -1247,7 +1253,7 @@ static void *cpu_map_data__alloc(const struct perf_cpu_map *map, size_t *size,
>  		*type  = PERF_CPU_MAP__MASK;
>  	}
>  
> -	*size += sizeof(struct perf_record_cpu_map_data);
> +	*size += sizeof(__u16); /* For perf_record_cpu_map_data.type. */
>  	*size = PERF_ALIGN(*size, sizeof(u64));
>  	return zalloc(*size);
>  }
> @@ -1260,10 +1266,10 @@ static void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data,
>  
>  	switch (type) {
>  	case PERF_CPU_MAP__CPUS:
> -		synthesize_cpus((struct cpu_map_entries *) data->data, map);
> +		synthesize_cpus(data, map);
>  		break;
>  	case PERF_CPU_MAP__MASK:
> -		synthesize_mask((struct perf_record_record_cpu_map *)data->data, map, max);
> +		synthesize_mask(data, map, max);
>  	default:
>  		break;
>  	}
> @@ -1271,7 +1277,7 @@ static void cpu_map_data__synthesize(struct perf_record_cpu_map_data *data,
>  
>  static struct perf_record_cpu_map *cpu_map_event__new(const struct perf_cpu_map *map)
>  {
> -	size_t size = sizeof(struct perf_record_cpu_map);
> +	size_t size = sizeof(struct perf_event_header);
>  	struct perf_record_cpu_map *event;
>  	int max;
>  	u16 type;
> -- 
> 2.36.1.476.g0c4daa206d-goog
> 
