Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F4556C5EC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 04:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiGICEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 22:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGICEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 22:04:00 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF635E312
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:03:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so293982ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 19:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OezEBl0OMJJ+7Kc3NMVkOfYcKC2GvNQvDhGPvh9nLMc=;
        b=rd625VKENraqmuoeOr/ugJ4GPax+nlYNvjwj2WIHhVyPNOvbBy3bE2dp7PpsZATt7n
         GQK8MSyoImKoGGZAJ2eOvL0MGKDZ3GmNr+AjzmJnXoVXGH6V6ZKbk3v5n/pAW4hXwn1M
         Lm5xTUnNazLmAaJc83lEXcs4OfFf67Hjm2qC62E/zIzVDg1k3semEqyX228QIMZ0Bu1U
         jko1YKPhPJMRI4D5xcedNzrLYLYTPkVfBcuWtoaguuGzj6qzNUPgMI0P2api/D13Jisf
         YsxiOA8rhd6IoMaPNnnc2hshjrgc3ZK6bEZmwZmWlQX7lm6lXSZkgyFa7g6ENgac/LRp
         jjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OezEBl0OMJJ+7Kc3NMVkOfYcKC2GvNQvDhGPvh9nLMc=;
        b=ylsZyMHGMH4hCuecZdneIMG4fQj69mESfl1lBN+IH+n905d7YdXekTXo1y4gwzq8rU
         tgTACwjaMb3HBLrPTIJOAYv+HTVp6JEBenWs648Z5li/voJAZxHvfO+VdPuSCmMgxovQ
         mz07Czg5zqcsk8SL7qzJ7M19+S6SKsB1lb8TQi9Hgjzp60ZrssKhB6FLa4817VJIOnSd
         0DOr0pOmi972Isv8Gmnr/SRb4qHd3T6SmDvw2dMOPw0FGHzcFMIUX6Am4IcO3UiDCA7I
         r4Flv48G43ZXXBCirc50mgqJUxSvZKaDg+eF5qQpbbja4KXnUx3iaFryNqzUjPtXiK9x
         m5nw==
X-Gm-Message-State: AJIora/QDf4zIGYkVHZCGSAnkF6PtUXv2+Ct3OICMKcSFkNlnjv/zCYi
        MDUnbGid4yWAPlZd4qiEGqy7+yzNb5Eqhw==
X-Google-Smtp-Source: AGRyM1u3i7KcuyQkYM0KCTmxwSnUvZ+10826X2uyepp6zX8nhpS6rVvxwnkS5nLuoS4lEssz/WluJnYi9ITSHA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a0d:cbd8:0:b0:31d:a46:a1ee with SMTP id
 n207-20020a0dcbd8000000b0031d0a46a1eemr7321378ywd.201.1657332237913; Fri, 08
 Jul 2022 19:03:57 -0700 (PDT)
Date:   Sat, 9 Jul 2022 02:03:55 +0000
In-Reply-To: <20220709002858.129534-1-roman.gushchin@linux.dev>
Message-Id: <20220709020355.bz7p4k34yw46iesp@google.com>
Mime-Version: 1.0
References: <20220709002858.129534-1-roman.gushchin@linux.dev>
Subject: Re: [PATCH bpf-next] bpf: reparent bpf maps on memcg offlining
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 05:28:58PM -0700, Roman Gushchin wrote:
> The memory consumed by a mpf map is always accounted to the memory
> cgroup of the process which created the map. The map can outlive
> the memory cgroup if it's used by processes in other cgroups or
> is pinned on bpffs. In this case the map pins the original cgroup
> in the dying state.
> 
> For other types of objects (slab objects, non-slab kernel allocations,
> percpu objects and recently LRU pages) there is a reparenting process
> implemented: on cgroup offlining charged objects are getting
> reassigned to the parent cgroup. Because all charges and statistics
> are fully recursive it's a fairly cheap operation.
> 
> For efficiency and consistency with other types of objects, let's do
> the same for bpf maps. Fortunately thanks to the objcg API, the
> required changes are minimal.
> 
> Please, note that individual allocations (slabs, percpu and large
> kmallocs) already have the reparenting mechanism. This commit adds
> it to the saved map->memcg pointer by replacing it to map->objcg.
> Because dying cgroups are not visible for a user and all charges are
> recursive, this commit doesn't bring any behavior changes for a user.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
