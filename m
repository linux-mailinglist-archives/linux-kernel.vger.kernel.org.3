Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6838453C06A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiFBVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFBVhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:37:34 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A2ED124;
        Thu,  2 Jun 2022 14:37:32 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e656032735so8493868fac.0;
        Thu, 02 Jun 2022 14:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxuGkkHNWWeLUeTuvMQnzB7XapVuPrv4oDcnUHBUEBQ=;
        b=W9btRF7Zn/JmoiwNTzfPNjbzz4sVHW3ei9u3D2aP22I4Oc3U6suXzm11OKWjRi2qd5
         Mt9BBuZB/sQvI1UkI9L3mzi8eoYFl5f0d0G9ZH2bYFj+ij5+/YRXfHuZfR16mQGHoUEo
         Ik/UCF0fgmCvIETxvIVwLO8sQ1x4nfBMuUzxLP3mkHBlV2JyVRth8c65W8TbVMxsG8+5
         qvK9Q31pQk9oLn0qw7as274H3kD7d2JdAZs7qlKu2bZGnYovyRPegY1myUIuWaoXvIej
         pLaryq/8IwhwjnBRVOq14guor8z8jfXypsvoxF/SVmY1GnWLvNCS6uiPYs9k2hjsVyPu
         r/Gg==
X-Gm-Message-State: AOAM530np9eQ54yPaNIy+cZ56A8tUgrrHLrm0EjgLhefMWx6PbmiMV/0
        MHsgo28V7gdVoRs214ap2ozi6lts/nSyVFX+uQg=
X-Google-Smtp-Source: ABdhPJxvgDk+bQS/verwzsiLD+3OEY1d3HlqZSfvZUr+Ie97LPC53JPeH8yLaAjg4aAc5mue2i4h4+fSUOq8RQd5Khk=
X-Received: by 2002:a05:6871:215:b0:f1:8bf5:23ab with SMTP id
 t21-20020a056871021500b000f18bf523abmr3857072oad.92.1654205851711; Thu, 02
 Jun 2022 14:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220601032608.1034-1-ravi.bangoria@amd.com> <20220601032608.1034-5-ravi.bangoria@amd.com>
In-Reply-To: <20220601032608.1034-5-ravi.bangoria@amd.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 2 Jun 2022 14:37:20 -0700
Message-ID: <CAM9d7cgraWne_NRGFqscWbYSx5nue_A2fJCQ-OaQBTC3g0eijg@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] perf headers: Store pmu caps in an array of strings
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>, rrichter@amd.com,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        James Clark <james.clark@arm.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>, like.xu.linux@gmail.com,
        x86@kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sandipan Das <sandipan.das@amd.com>, ananth.narayan@amd.com,
        Kim Phillips <kim.phillips@amd.com>, santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:28 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> Currently all capabilities are stored in a single string separated
> by NULL character. Instead, store them in an array which makes
> searching of capability easier.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
[SNIP]
> @@ -3231,12 +3226,16 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>                 if (!value)
>                         goto free_name;
>
> -               if (strbuf_addf(&sb, "%s=%s", name, value) < 0)
> +               name_size = strlen(name);
> +               value_size = strlen(value);
> +               ptr = zalloc(sizeof(char) * (name_size + value_size + 2));
> +               if (!ptr)
>                         goto free_value;
>
> -               /* include a NULL character at the end */
> -               if (strbuf_add(&sb, "", 1) < 0)
> -                       goto free_value;
> +               memcpy(ptr, name, name_size);
> +               ptr[name_size] = '=';
> +               memcpy(ptr + name_size + 1, value, value_size);

What about using asprintf() instead?

Thanks,
Namhyung


> +               (*cpu_pmu_caps)[i] = ptr;
>
>                 if (!strcmp(name, "branches"))
>                         *max_branches = atoi(value);
> @@ -3244,7 +3243,7 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>                 free(value);
>                 free(name);
>         }
> -       *cpu_pmu_caps = strbuf_detach(&sb, NULL);
> +       *nr_cpu_pmu_caps = nr_caps;
>         return 0;
>
>  free_value:
> @@ -3252,16 +3251,24 @@ static int process_per_cpu_pmu_caps(struct feat_fd *ff, int *nr_cpu_pmu_caps,
>  free_name:
>         free(name);
>  error:
> -       strbuf_release(&sb);
> +       for (; i > 0; i--)
> +               free((*cpu_pmu_caps)[i - 1]);
> +       free(*cpu_pmu_caps);
> +       *cpu_pmu_caps = NULL;
> +       *nr_cpu_pmu_caps = 0;
>         return -1;
>  }
>
>  static int process_cpu_pmu_caps(struct feat_fd *ff,
>                                 void *data __maybe_unused)
>  {
> -       return process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
> +       int ret = process_per_cpu_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
>                                         &ff->ph->env.cpu_pmu_caps,
>                                         &ff->ph->env.max_branches);
> +
> +       if (!ret && !ff->ph->env.cpu_pmu_caps)
> +               pr_debug("cpu pmu capabilities not available\n");
> +       return ret;
>  }
>
>  static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
> @@ -3270,6 +3277,7 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>         struct hybrid_cpc_node *nodes;
>         u32 nr_pmu, i;
>         int ret;
> +       int j;
>
>         if (do_read_u32(ff, &nr_pmu))
>                 return -1;
> @@ -3297,6 +3305,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>                         ret = -1;
>                         goto err;
>                 }
> +               if (!n->nr_cpu_pmu_caps)
> +                       pr_debug("%s pmu capabilities not available\n", n->pmu_name);
>         }
>
>         ff->ph->env.nr_hybrid_cpc_nodes = nr_pmu;
> @@ -3305,6 +3315,8 @@ static int process_hybrid_cpu_pmu_caps(struct feat_fd *ff,
>
>  err:
>         for (i = 0; i < nr_pmu; i++) {
> +               for (j = 0; j < nodes[i].nr_cpu_pmu_caps; j++)
> +                       free(nodes[i].cpu_pmu_caps[j]);
>                 free(nodes[i].cpu_pmu_caps);
>                 free(nodes[i].pmu_name);
>         }
> --
> 2.31.1
>
