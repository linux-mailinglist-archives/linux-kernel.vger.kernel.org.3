Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D954ED409
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiCaGlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiCaGlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:41:47 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEF3656F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:40:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x9-20020a5b0809000000b00631d9edfb96so17185699ybp.22
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=2EO1zCBkMeInrvtUm5zFLSJgdsvUYdhYvGrInIQEHn8=;
        b=BuraXhTICGesUuAWshpPBGws+qpwfbbToioiwotOHb/5C7i4EF/ANXjMpswRm2Amcy
         NzVB9MrpgHzoXUX4+6yujhXOdX4S1tUk9vWlZGm39O2Mikz+KUApMWDYtFXEqkYh7Luw
         zyh+TARfdaiF3PszRIMmm/mzUHOeGUT/0fWReMG5Fyj9dn/LjNoGbC1OWvFCT2tk06ge
         aQfZPXeGJ4grNqItzGlUsH0WFjVwzTPu2I1HyXPDW/RnZlPBtSUJ3984lac5I3jwsNvD
         srATOlGPmkvXo3TEQ3WQ4pHZ55OCSFX93ec/0vMwhOd5xmRlCWLOoolX/XTXpiNH9uyq
         AqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=2EO1zCBkMeInrvtUm5zFLSJgdsvUYdhYvGrInIQEHn8=;
        b=HUrrRQ0HKuqq+puaOMjJIp9YdnOFfECLcXk6bnP2MITyzHN6jm3fB6F/6p+269jLzv
         WPcMw6ar9zeR1cBr8kBj99QhyRBa36xHBWsWnaTXP5itv3kw+KMOfsZ+Co3FbWMZeRQV
         wXXr6kmIpv+Fthr6cPDWZ2u5/qRwlUJPdQzqz3YfTiw1wiw4Lbp+XIZ5i2d/9nv3tk9c
         nnPR2suxtv1sV4f+XjaSuhh96VWDjcha//dOMJyxXD17h+15xIat9xoVn89DgLDUwEdm
         bjEA0BfryisXulO7qxC5DZ6bVVpaUS3+kjrUcOa6mjKUw3auB0usy9WaIqNsqaM0eU2S
         0w/w==
X-Gm-Message-State: AOAM531qzDZSnfrOguyxVaBmCAIVsj3XgDFGSrZmS1B496WktNZT2/Os
        kNa2wZxjVg1LgONOIy3QjClo3P1PbcS6vw==
X-Google-Smtp-Source: ABdhPJyt7GDJgAVqiqYMHwpK4PthMSnXQEN6sLNCWOjUDvSjiidXMxyP21GtktoorZ34FUmloIhvrzRQBKD8QA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:b889:0:b0:633:c93e:3e18 with SMTP id
 w9-20020a25b889000000b00633c93e3e18mr3141444ybj.263.1648708799467; Wed, 30
 Mar 2022 23:39:59 -0700 (PDT)
Date:   Thu, 31 Mar 2022 06:39:56 +0000
In-Reply-To: <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
Message-Id: <20220331063956.5uqnab64cqnmcwyr@google.com>
Mime-Version: 1.0
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org> <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 07:48:45PM -0700, Roman Gushchin wrote:
>=20
>=20
[...]
>=20
>=20
> But honestly, I=E2=80=99d drop the original optimization together with th=
e fix, if only there is no _real world_ data on the problem and the improve=
ment. It seems like it has started as a nice simple improvement, but the ra=
ce makes it complex and probably not worth the added complexity and fragili=
ty.

I agree with dropping the original optimization as it is not really
fixing an observed issue which may justify adding some complexity.

thanks,
Shakeel
