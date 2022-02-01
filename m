Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6981E4A58FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbiBAJNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:13:19 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53592 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbiBAJNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:13:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C930B82D1B;
        Tue,  1 Feb 2022 09:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936A2C340F0;
        Tue,  1 Feb 2022 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643706794;
        bh=M8/HA0NeuoGfTEoeqpsD3EiTu6HWy96swixvLfGHc94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KukHZXBdVLS/V0ATUIap770b3fP2ezWKjiSHPz1btAiz/ouDtLbzrVU7eB7aYoCiw
         BfWFrtgPZbM0zrkbY/jqeQ7GthPpz0levw190wxbZmGsdN5aJOm9HyhmDp21XS9oUG
         8BFXQuzs9NwRaSEl/6vpXZTKvFTImr99GxVi52v4pVa55TBJrRgPG9DwVMVihRf/V+
         WbOydewXUhVayKNNNexA/FLHu5OZmwfkVLEEmyYanywG/5BaiqHZXzfJdmuUtlc/7R
         pH6NGQJDx2QIuEdfPuNSAk/1PmdaLe4hiwj0hZKzLu+qwcH2xGCh4T/RkadD47QaOE
         IX6/3AVifpSDA==
Received: by mail-wr1-f47.google.com with SMTP id s18so30577291wrv.7;
        Tue, 01 Feb 2022 01:13:14 -0800 (PST)
X-Gm-Message-State: AOAM533cKRXa0yyiUAaidchTUhOFxe1siMgQFYtyOhPGlvQZsFGMQgle
        QxD705JkvmEyBgDiqoeMw69IVRhAJgkzXvnNipQ=
X-Google-Smtp-Source: ABdhPJwpWMlnABXWM6hZCahA4qT1K08exblSso3TDSBHM/OzFWW2l+kkNoPQAMqs6Oxl1UlEvnbYg4Bv7/9acQJ0MbM=
X-Received: by 2002:a05:6000:1c9:: with SMTP id t9mr21035776wrx.550.1643706792825;
 Tue, 01 Feb 2022 01:13:12 -0800 (PST)
MIME-Version: 1.0
References: <20220128083835.13890-1-tianjia.zhang@linux.alibaba.com>
In-Reply-To: <20220128083835.13890-1-tianjia.zhang@linux.alibaba.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Feb 2022 10:13:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEfNCdyWQ-=OXEzoqduob-MWscxGt2xBcjF08Dh30NxyA@mail.gmail.com>
Message-ID: <CAMj1kXEfNCdyWQ-=OXEzoqduob-MWscxGt2xBcjF08Dh30NxyA@mail.gmail.com>
Subject: Re: [PATCH] crypto: tcrypt - remove all multibuffer ahash tests
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 at 09:38, Tianjia Zhang
<tianjia.zhang@linux.alibaba.com> wrote:
>
> The multibuffer algorithms was removed already in 2018, so it is
> necessary to clear the test code left by tcrypt.
>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  crypto/tcrypt.c | 224 ------------------------------------------------
>  1 file changed, 224 deletions(-)
>
> diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
> index 82b5eef2246a..2a808e843de5 100644
> --- a/crypto/tcrypt.c
> +++ b/crypto/tcrypt.c
> @@ -724,200 +724,6 @@ static inline int do_one_ahash_op(struct ahash_request *req, int ret)
>         return crypto_wait_req(ret, wait);
>  }
>
> -struct test_mb_ahash_data {
> -       struct scatterlist sg[XBUFSIZE];
> -       char result[64];
> -       struct ahash_request *req;
> -       struct crypto_wait wait;
> -       char *xbuf[XBUFSIZE];
> -};
> -
> -static inline int do_mult_ahash_op(struct test_mb_ahash_data *data, u32 num_mb,
> -                                  int *rc)
> -{
> -       int i, err = 0;
> -
> -       /* Fire up a bunch of concurrent requests */
> -       for (i = 0; i < num_mb; i++)
> -               rc[i] = crypto_ahash_digest(data[i].req);
> -
> -       /* Wait for all requests to finish */
> -       for (i = 0; i < num_mb; i++) {
> -               rc[i] = crypto_wait_req(rc[i], &data[i].wait);
> -
> -               if (rc[i]) {
> -                       pr_info("concurrent request %d error %d\n", i, rc[i]);
> -                       err = rc[i];
> -               }
> -       }
> -
> -       return err;
> -}
> -
> -static int test_mb_ahash_jiffies(struct test_mb_ahash_data *data, int blen,
> -                                int secs, u32 num_mb)
> -{
> -       unsigned long start, end;
> -       int bcount;
> -       int ret = 0;
> -       int *rc;
> -
> -       rc = kcalloc(num_mb, sizeof(*rc), GFP_KERNEL);
> -       if (!rc)
> -               return -ENOMEM;
> -
> -       for (start = jiffies, end = start + secs * HZ, bcount = 0;
> -            time_before(jiffies, end); bcount++) {
> -               ret = do_mult_ahash_op(data, num_mb, rc);
> -               if (ret)
> -                       goto out;
> -       }
> -
> -       pr_cont("%d operations in %d seconds (%llu bytes)\n",
> -               bcount * num_mb, secs, (u64)bcount * blen * num_mb);
> -
> -out:
> -       kfree(rc);
> -       return ret;
> -}
> -
> -static int test_mb_ahash_cycles(struct test_mb_ahash_data *data, int blen,
> -                               u32 num_mb)
> -{
> -       unsigned long cycles = 0;
> -       int ret = 0;
> -       int i;
> -       int *rc;
> -
> -       rc = kcalloc(num_mb, sizeof(*rc), GFP_KERNEL);
> -       if (!rc)
> -               return -ENOMEM;
> -
> -       /* Warm-up run. */
> -       for (i = 0; i < 4; i++) {
> -               ret = do_mult_ahash_op(data, num_mb, rc);
> -               if (ret)
> -                       goto out;
> -       }
> -
> -       /* The real thing. */
> -       for (i = 0; i < 8; i++) {
> -               cycles_t start, end;
> -
> -               start = get_cycles();
> -               ret = do_mult_ahash_op(data, num_mb, rc);
> -               end = get_cycles();
> -
> -               if (ret)
> -                       goto out;
> -
> -               cycles += end - start;
> -       }
> -
> -       pr_cont("1 operation in %lu cycles (%d bytes)\n",
> -               (cycles + 4) / (8 * num_mb), blen);
> -
> -out:
> -       kfree(rc);
> -       return ret;
> -}
> -
> -static void test_mb_ahash_speed(const char *algo, unsigned int secs,
> -                               struct hash_speed *speed, u32 num_mb)
> -{
> -       struct test_mb_ahash_data *data;
> -       struct crypto_ahash *tfm;
> -       unsigned int i, j, k;
> -       int ret;
> -
> -       data = kcalloc(num_mb, sizeof(*data), GFP_KERNEL);
> -       if (!data)
> -               return;
> -
> -       tfm = crypto_alloc_ahash(algo, 0, 0);
> -       if (IS_ERR(tfm)) {
> -               pr_err("failed to load transform for %s: %ld\n",
> -                       algo, PTR_ERR(tfm));
> -               goto free_data;
> -       }
> -
> -       for (i = 0; i < num_mb; ++i) {
> -               if (testmgr_alloc_buf(data[i].xbuf))
> -                       goto out;
> -
> -               crypto_init_wait(&data[i].wait);
> -
> -               data[i].req = ahash_request_alloc(tfm, GFP_KERNEL);
> -               if (!data[i].req) {
> -                       pr_err("alg: hash: Failed to allocate request for %s\n",
> -                              algo);
> -                       goto out;
> -               }
> -
> -               ahash_request_set_callback(data[i].req, 0, crypto_req_done,
> -                                          &data[i].wait);
> -
> -               sg_init_table(data[i].sg, XBUFSIZE);
> -               for (j = 0; j < XBUFSIZE; j++) {
> -                       sg_set_buf(data[i].sg + j, data[i].xbuf[j], PAGE_SIZE);
> -                       memset(data[i].xbuf[j], 0xff, PAGE_SIZE);
> -               }
> -       }
> -
> -       pr_info("\ntesting speed of multibuffer %s (%s)\n", algo,
> -               get_driver_name(crypto_ahash, tfm));
> -
> -       for (i = 0; speed[i].blen != 0; i++) {
> -               /* For some reason this only tests digests. */
> -               if (speed[i].blen != speed[i].plen)
> -                       continue;
> -
> -               if (speed[i].blen > XBUFSIZE * PAGE_SIZE) {
> -                       pr_err("template (%u) too big for tvmem (%lu)\n",
> -                              speed[i].blen, XBUFSIZE * PAGE_SIZE);
> -                       goto out;
> -               }
> -
> -               if (klen)
> -                       crypto_ahash_setkey(tfm, tvmem[0], klen);
> -
> -               for (k = 0; k < num_mb; k++)
> -                       ahash_request_set_crypt(data[k].req, data[k].sg,
> -                                               data[k].result, speed[i].blen);
> -
> -               pr_info("test%3u "
> -                       "(%5u byte blocks,%5u bytes per update,%4u updates): ",
> -                       i, speed[i].blen, speed[i].plen,
> -                       speed[i].blen / speed[i].plen);
> -
> -               if (secs) {
> -                       ret = test_mb_ahash_jiffies(data, speed[i].blen, secs,
> -                                                   num_mb);
> -                       cond_resched();
> -               } else {
> -                       ret = test_mb_ahash_cycles(data, speed[i].blen, num_mb);
> -               }
> -
> -
> -               if (ret) {
> -                       pr_err("At least one hashing failed ret=%d\n", ret);
> -                       break;
> -               }
> -       }
> -
> -out:
> -       for (k = 0; k < num_mb; ++k)
> -               ahash_request_free(data[k].req);
> -
> -       for (k = 0; k < num_mb; ++k)
> -               testmgr_free_buf(data[k].xbuf);
> -
> -       crypto_free_ahash(tfm);
> -
> -free_data:
> -       kfree(data);
> -}
> -
>  static int test_ahash_jiffies_digest(struct ahash_request *req, int blen,
>                                      char *out, int secs)
>  {
> @@ -2574,36 +2380,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
>                 test_ahash_speed("sm3", sec, generic_hash_speed_template);
>                 if (mode > 400 && mode < 500) break;
>                 fallthrough;
> -       case 450:
> -               test_mb_ahash_speed("sha1", sec, generic_hash_speed_template,
> -                                   num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
> -       case 451:
> -               test_mb_ahash_speed("sha256", sec, generic_hash_speed_template,
> -                                   num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
> -       case 452:
> -               test_mb_ahash_speed("sha512", sec, generic_hash_speed_template,
> -                                   num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
> -       case 453:
> -               test_mb_ahash_speed("sm3", sec, generic_hash_speed_template,
> -                                   num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
> -       case 454:
> -               test_mb_ahash_speed("streebog256", sec,
> -                                   generic_hash_speed_template, num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
> -       case 455:
> -               test_mb_ahash_speed("streebog512", sec,
> -                                   generic_hash_speed_template, num_mb);
> -               if (mode > 400 && mode < 500) break;
> -               fallthrough;
>         case 499:
>                 break;
>
> --
> 2.34.1
>
