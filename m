Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055575833B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 21:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbiG0Tfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 15:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbiG0Tft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 15:35:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3874E87F;
        Wed, 27 Jul 2022 12:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC3661A9F;
        Wed, 27 Jul 2022 19:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E652C433C1;
        Wed, 27 Jul 2022 19:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658950546;
        bh=SAA2jst8qEvG86qSOqMb2Iu+4PBoN2K97VJ9IudGAAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jA34QOJlKWQAghcqU9npOKDGiDG7FH9U6HJht9BC4+ANlVqKm4/25IpQsC+RAQOtZ
         jFmrNGuivX/E8LWjdo1dcVM/iYqrLSpcxOMzwvpagC1mlJljl73bA4oLcI5oJUo0uf
         pgZPFIh74vFWueKysSUFiqSbTSDIaOVhs26VGq2XHtvgHiFBzxImuvVBmb3mO4OSW+
         MNTjXR37lJZRBTfkw8F/XNU2EbE98VaqcmrePi9H41NUR7vPLGeVsEmOoAcRUntW4x
         z5su8RqHTGyKhPLWOqXvVIMvZnH5L7+xuFFTbH8mIneEfC75qBk6LG4jMO1KMmaJuH
         cX7c+ykiGRbWw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7D705405DD; Wed, 27 Jul 2022 16:35:42 -0300 (-03)
Date:   Wed, 27 Jul 2022 16:35:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     gpavithrasha@gmail.com
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 1/4] perf mutex: Wrapped usage of pthread_mutex_t
Message-ID: <YuGTjvLUbehHe/Pj@kernel.org>
References: <20220727111954.105118-1-gpavithrasha@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727111954.105118-1-gpavithrasha@gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 27, 2022 at 04:49:51PM +0530, gpavithrasha@gmail.com escreveu:
> From: pavithra <gpavithrasha@gmail.com>
> 
> Added a new header file mutex.h that wraps the
> usage of pthread_mutex_t and updated lock in dso.h.

Hi,

	You should create a first patch with just the new mutex.c and
mutex.h files, then you go on to change the users of
pthread_mutex_lock/unlock to the wrappers.

	Also please add the license on the first line of the new
mutex.[ch] files, see Documentation/process/license-rules.rst.

	tldr; probably what you want is to have this single line in
those the two new files (mutex.[ch]):

// SPDX-License-Identifier: GPL-2.0


 
> Signed-off-by: pavithra <gpavithrasha@gmail.com>
> ---
>  tools/perf/util/Build    |  1 +
>  tools/perf/util/dso.c    | 33 ++++++++++++++++-----------------
>  tools/perf/util/dso.h    |  3 ++-
>  tools/perf/util/mutex.c  | 32 ++++++++++++++++++++++++++++++++
>  tools/perf/util/mutex.h  | 15 +++++++++++++++
>  tools/perf/util/symbol.c |  4 ++--
>  6 files changed, 68 insertions(+), 20 deletions(-)
>  create mode 100644 tools/perf/util/mutex.c
>  create mode 100644 tools/perf/util/mutex.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 8dcfca1a882f..559c20d94c36 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -120,6 +120,7 @@ perf-y += time-utils.o
>  perf-y += expr-bison.o
>  perf-y += branch.o
>  perf-y += mem2node.o
> +perf-y += mutex.o
>  
>  perf-$(CONFIG_LIBBPF) += bpf-loader.o
>  perf-$(CONFIG_LIBBPF) += bpf_map.o
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index e11ddf86f2b3..605c31585d48 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -426,7 +426,7 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
>   */
>  static LIST_HEAD(dso__data_open);
>  static long dso__data_open_cnt;
> -static pthread_mutex_t dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;
> +static struct mutex dso__data_open_lock = PTHREAD_MUTEX_INITIALIZER;

Please find in include/linux/mutex.h the replacement for
PTHREAD_MUTEX_INITIALIZER, since we're trying to mimic the kernel mutex
api.

>  
>  static void dso__list_add(struct dso *dso)
>  {
> @@ -633,9 +633,9 @@ static void check_data_close(void)
>   */
>  void dso__data_close(struct dso *dso)
>  {
> -	pthread_mutex_lock(&dso__data_open_lock);
> +	mutex_lock(&dso__data_open_lock);
>  	close_dso(dso);
> -	pthread_mutex_unlock(&dso__data_open_lock);
> +	mutex_unlock(&dso__data_open_lock);
>  }
>  
>  static void try_to_open_dso(struct dso *dso, struct machine *machine)
> @@ -684,20 +684,19 @@ int dso__data_get_fd(struct dso *dso, struct machine *machine)
>  	if (dso->data.status == DSO_DATA_STATUS_ERROR)
>  		return -1;
>  
> -	if (pthread_mutex_lock(&dso__data_open_lock) < 0)
> -		return -1;
> +	mutex_lock(&dso__data_open_lock);
>  
>  	try_to_open_dso(dso, machine);
>  
>  	if (dso->data.fd < 0)
> -		pthread_mutex_unlock(&dso__data_open_lock);
> +		mutex_unlock(&dso__data_open_lock);
>  
>  	return dso->data.fd;
>  }
>  
>  void dso__data_put_fd(struct dso *dso __maybe_unused)
>  {
> -	pthread_mutex_unlock(&dso__data_open_lock);
> +	mutex_unlock(&dso__data_open_lock);
>  }
>  
>  bool dso__data_status_seen(struct dso *dso, enum dso_data_status_seen by)
> @@ -756,7 +755,7 @@ dso_cache__free(struct dso *dso)
>  	struct rb_root *root = &dso->data.cache;
>  	struct rb_node *next = rb_first(root);
>  
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  	while (next) {
>  		struct dso_cache *cache;
>  
> @@ -765,7 +764,7 @@ dso_cache__free(struct dso *dso)
>  		rb_erase(&cache->rb_node, root);
>  		free(cache);
>  	}
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  }
>  
>  static struct dso_cache *dso_cache__find(struct dso *dso, u64 offset)
> @@ -802,7 +801,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
>  	struct dso_cache *cache;
>  	u64 offset = new->offset;
>  
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  	while (*p != NULL) {
>  		u64 end;
>  
> @@ -823,7 +822,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
>  
>  	cache = NULL;
>  out:
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  	return cache;
>  }
>  
> @@ -843,7 +842,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
>  {
>  	ssize_t ret;
>  
> -	pthread_mutex_lock(&dso__data_open_lock);
> +	mutex_lock(&dso__data_open_lock);
>  
>  	/*
>  	 * dso->data.fd might be closed if other thread opened another
> @@ -859,7 +858,7 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
>  
>  	ret = pread(dso->data.fd, data, DSO__DATA_CACHE_SIZE, offset);
>  out:
> -	pthread_mutex_unlock(&dso__data_open_lock);
> +	mutex_unlock(&dso__data_open_lock);
>  	return ret;
>  }
>  
> @@ -953,7 +952,7 @@ static int file_size(struct dso *dso, struct machine *machine)
>  	struct stat st;
>  	char sbuf[STRERR_BUFSIZE];
>  
> -	pthread_mutex_lock(&dso__data_open_lock);
> +	mutex_lock(&dso__data_open_lock);
>  
>  	/*
>  	 * dso->data.fd might be closed if other thread opened another
> @@ -977,7 +976,7 @@ static int file_size(struct dso *dso, struct machine *machine)
>  	dso->data.file_size = st.st_size;
>  
>  out:
> -	pthread_mutex_unlock(&dso__data_open_lock);
> +	mutex_unlock(&dso__data_open_lock);
>  	return ret;
>  }
>  
> @@ -1192,7 +1191,7 @@ struct dso *dso__new(const char *name)
>  		dso->root = NULL;
>  		INIT_LIST_HEAD(&dso->node);
>  		INIT_LIST_HEAD(&dso->data.open_entry);
> -		pthread_mutex_init(&dso->lock, NULL);
> +		mutex_init(&dso->lock);
>  		refcount_set(&dso->refcnt, 1);
>  	}
>  
> @@ -1226,7 +1225,7 @@ void dso__delete(struct dso *dso)
>  	dso__free_a2l(dso);
>  	zfree(&dso->symsrc_filename);
>  	nsinfo__zput(dso->nsinfo);
> -	pthread_mutex_destroy(&dso->lock);
> +	mutex_destroy(&dso->lock);
>  	free(dso);
>  }
>  
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index e4dddb76770d..e08b2ab48314 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -11,6 +11,7 @@
>  #include <stdio.h>
>  #include <linux/bitops.h>
>  #include "build-id.h"
> +#include "mutex.h"
>  
>  struct machine;
>  struct map;
> @@ -132,7 +133,7 @@ struct dso_cache {
>  struct auxtrace_cache;
>  
>  struct dso {
> -	pthread_mutex_t	 lock;
> +	struct mutex lock;

There was a previous alignment of the member names, when you see
something like this in code you're changing, please keep the style.

>  	struct list_head node;
>  	struct rb_node	 rb_node;	/* rbtree node sorted by long name */
>  	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
> diff --git a/tools/perf/util/mutex.c b/tools/perf/util/mutex.c
> new file mode 100644
> index 000000000000..b7264a1438c4
> --- /dev/null
> +++ b/tools/perf/util/mutex.c
> @@ -0,0 +1,32 @@
> +#include <mutex.h>
> +#include <pthread.h>
> +
> +//to avoid the warning : implicit declaration of BUG_ON,
> +//we add the following 2 headers.
> +#include <linux/compiler.h>
> +#include <linux/kernel.h>
> +
> +void mutex_init(struct mutex *mtx)
> +{
> +pthread_mutexattr_t lock_attr;
> +pthread_mutexattr_init(&lock_attr);
> +pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> +BUG_ON(pthread_mutex_init(&mtx->lock, &lock_attr));
> +//on success, returns 0.
> +pthread_mutexattr_destroy(&lock_attr);
> +}
> +
> +void mutex_destroy(struct mutex *mtx)
> +{
> +BUG_ON(pthread_mutex_destroy(&mtx->lock));     //on success, returns 0.
> +}
> +
> +void mutex_lock(struct mutex *mtx)
> +{
> +BUG_ON(pthread_mutex_lock(&mtx->lock) != 0);
> +}
> +
> +void mutex_unlock(struct mutex *mtx)
> +{
> +BUG_ON(pthread_mutex_unlock(&mtx->lock) != 0);
> +}
> diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
> new file mode 100644
> index 000000000000..ab2ebb98b24a
> --- /dev/null
> +++ b/tools/perf/util/mutex.h
> @@ -0,0 +1,15 @@
> +#ifndef __PERF_MUTEX_H
> +#define _PERF_MUTEX_H
> +
> +#include <pthread.h>
> +
> +struct mutex {
> +pthread_mutex_t lock;
> +};
> +
> +void mutex_lock(struct mutex *mtx);
> +void mutex_unlock(struct mutex *mtx);
> +void mutex_init(struct mutex *mtx);
> +void mutex_destroy(struct mutex *mtx);
> +
> +#endif /* _PERF_MUTEX_H */
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index a8f80e427674..342be12cfa1e 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1629,7 +1629,7 @@ int dso__load(struct dso *dso, struct map *map)
>  	}
>  
>  	nsinfo__mountns_enter(dso->nsinfo, &nsc);
> -	pthread_mutex_lock(&dso->lock);
> +	mutex_lock(&dso->lock);
>  
>  	/* check again under the dso->lock */
>  	if (dso__loaded(dso)) {
> @@ -1778,7 +1778,7 @@ int dso__load(struct dso *dso, struct map *map)
>  		ret = 0;
>  out:
>  	dso__set_loaded(dso);
> -	pthread_mutex_unlock(&dso->lock);
> +	mutex_unlock(&dso->lock);
>  	nsinfo__mountns_exit(&nsc);
>  
>  	return ret;
> -- 
> 2.25.1
> 

-- 

- Arnaldo
