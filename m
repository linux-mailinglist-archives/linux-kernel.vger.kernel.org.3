Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2B9529D05
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiEQIzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEQIy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:54:57 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920033D1DE
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:54:53 -0700 (PDT)
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220517085448epoutp02f03e08ec10d0beffecc3bc040eb51728~v2I0KcO_10088700887epoutp02J
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 08:54:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220517085448epoutp02f03e08ec10d0beffecc3bc040eb51728~v2I0KcO_10088700887epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652777688;
        bh=EdVzJdY8VY9+2Zp82gTstuLAAnxytkYIM1ITWTn8UQ0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rsqiXwbA4IE2be6sPdj9Utph2hDVAWq2lZ0qAJ1xxj6V9xtohKdbErLx6CCuR7s6k
         YZnydYJZv7w6Fpjre/rkB39DUgmKyCss3MuVe98GydAjuRC7BdOlTw2jZt7YskXYaU
         LwKn7lhST+qYZ/DQy/x5ROFp0OvsI8IEF5vTG7p8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517085447epcas1p2138673b137df341356658e9c734cd066~v2IzniaHs0898508985epcas1p2m;
        Tue, 17 May 2022 08:54:47 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.36.133]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4L2VLH0JlRz4x9Q9; Tue, 17 May
        2022 08:54:47 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.75.10038.6D263826; Tue, 17 May 2022 17:54:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97~v2IySwLMN2687326873epcas1p4D;
        Tue, 17 May 2022 08:54:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220517085446epsmtrp147735a5a6efbe7053c9342fb72e1bc8b~v2IyR5eV11935519355epsmtrp1d;
        Tue, 17 May 2022 08:54:46 +0000 (GMT)
X-AuditID: b6c32a37-127ff70000002736-f5-628362d60aff
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.18.11276.6D263826; Tue, 17 May 2022 17:54:46 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220517085446epsmtip2ead2da90943f0d4e0149fa8b7120e569~v2IyCwP0v0311703117epsmtip2U;
        Tue, 17 May 2022 08:54:46 +0000 (GMT)
From:   Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, m.szyprowski@samsung.com,
        saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v5 0/4] PM / devfreq: Add cpu based scaling support to
 passive governor
Date:   Tue, 17 May 2022 18:21:04 +0900
Message-Id: <20220517092108.31680-1-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmvu61pOYkg+b15hbb179gtbj+5Tmr
        xYTW7cwWx/cvYbc49ivY4mzTG3aLy7vmsFl87j3CaLH2yF12i88bHjNa3G5cwWbRdegvm8WM
        tsusDrwesxsusngs2FTq0XJyP4tH35ZVjB6fN8kFsEZl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAt0CtOzC0uzUvXy0stsTI0MDAyBSpMyM74/qmTseCgSMWhp7fZGxgXCXYxcnJI
        CJhIrP9+nRXEFhLYwSjRf5G7i5ELyP4EZF/exwyR+MYosfhzIEzDjq3TGSGK9jJKXPzaxwLh
        fGGU2DH/HxNIFZuAlsT+FzfYQGwRASuJ0/87mEGKmAWmMElc2PMFLCEsEClxc+l7dhCbRUBV
        Yv28XYwgNi9Qw7uX55gh1slLrN5wAMq+xy6x67g5hO0icfjuTBYIW1ji1fEt7BC2lMTL/jZ2
        kGUSAs2MEg0vbjNCOD2MEkef9UF1GEvsXzoZ6FQOoJM0Jdbv0ocIK0rs/D0X7AhmAT6Jd197
        WEFKJAR4JTrahCBKlCUuP7jLBGFLSixu72SDKPGQ2Hq6ChJasRKN+36xTmCUnYUwfwEj4ypG
        sdSC4tz01GLDAmN4JCXn525iBKc6LfMdjNPeftA7xMjEwXiIUYKDWUmE16CiIUmINyWxsiq1
        KD++qDQntfgQoykwvCYyS4km5wOTbV5JvKGJpYGJmZGxiYWhmaGSOO+qaacThQTSE0tSs1NT
        C1KLYPqYODilGphORU8v262Uk2L5dnrHbzP2Aq3NjzfF39U+9cB/Wf9Kb6ZLDEknFDKY7k5Z
        bbTrePJ5lwrvSV6aTkZThX6FiaTafvvOEfL1XueORTvKt+rxvjjTwWdwoGP9oscdq/7c/Xh0
        80SbqHPLtGy+G/90jnkSVnim0YvLSG/rGkOVS5Oc6nr/fp7cw8twOH7xmu9dDhlNhmw6LtND
        9ScmlffYH09oetF72Vlk5lImrwuOm/4nCO9J/Mus8Jotg/Ft3ouFXksrW+awCjV/TZuTErKD
        Rf/RPYEVe8unH7c9FP/1Q5jWneCN659fmpM180nxlP7VqyKiNu4v/Gm37tStfaF7LFU4DVx+
        i7uwVJcUPvt2WmWTEktxRqKhFnNRcSIAbDY1pv4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFLMWRmVeSWpSXmKPExsWy7bCSvO61pOYkg6UHpSy2r3/BanH9y3NW
        iwmt25ktju9fwm5x7FewxdmmN+wWl3fNYbP43HuE0WLtkbvsFp83PGa0uN24gs2i69BfNosZ
        bZdZHXg9ZjdcZPFYsKnUo+XkfhaPvi2rGD0+b5ILYI3isklJzcksSy3St0vgyvj+qZOx4KBI
        xaGnt9kbGBcJdjFyckgImEjs2DqdsYuRi0NIYDejxPRJO5kgEpIS0y4eZe5i5ACyhSUOHy4G
        CQsJfGKUWHxMDcRmE9CS2P/iBhuILSJgI3F38TUWkDnMAouYJC5cXMgOkhAWCJdYNG8rWBGL
        gKrE+nm7GEFsXgEriXcvzzFD7JKXWL3hAPMERp4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL
        89L1kvNzNzGCg09Lcwfj9lUf9A4xMnEwHmKU4GBWEuE1qGhIEuJNSaysSi3Kjy8qzUktPsQo
        zcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoFpfXpd8OryKl0R19s9nW2HVhWdesDYc8Su
        RjDPfuasXedXLhUwyFy+U40hYvW6/ZHWBR+nbtWtfWVx9/jppbtOL7Ere/nTjTvkj/ZJn94H
        3FPuKbWELX1r4OR9WM/bNHhZcqbsk9k7Kzd99LuVIHQm9cex2BfTnz2sX/nuBdc76+N5H1kU
        qzb11rc9ktjdcuE1E0NoBefrLzoXXx1Jy7Rfenn34yW525XezNndw59gsWGehfMBRqHnNx7w
        3hdTNnV5G25ZoPz+YvSE3X7Mx6cXv9ogt+H8Ni/f38qBGRwBPmH3W6xSY5WD1TJZxIPVDr0T
        /WWz3Z2Bx2FbetFyjklOuiw+BaUe9d0m6+YyLLVRYinOSDTUYi4qTgQA43q8bq0CAAA=
X-CMS-MailID: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97
References: <CGME20220517085446epcas1p4c07ab7d3b80d62c0093c3a45484eae97@epcas1p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devfreq passive governor has already supported the devfreq parent device
for coupling the frequency change if some hardware have the constraints
such as power sharing and so on.

Add cpu based scaling support to passive governor with required-opp property.
It uses the cpufreq notifier to catch the frequency change timing of cpufreq
and get the next frequency according to new cpu frequency by using required-opp
property. It is based on patch[1] and then just code clean-up by myself.

Make the common code for both passive_devfreq and passive_cpufreq
parent type to remove the duplicate code.

[1] [RFC,v2] PM / devfreq: Add cpu based scaling support to passive_governor
- https://lore.kernel.org/patchwork/patch/1101049/

Changes from v4:
: https://patchwork.kernel.org/project/linux-pm/cover/20220511093554.17535-1-cw00.choi@samsung.com/
- Fix issue[2] reported by Marek Szyprowski
[2] https://patchwork.kernel.org/project/linux-pm/patch/20220511093554.17535-3-cw00.choi@samsung.com/

Changes from v3:
: ttps://patchwork.kernel.org/project/linux-pm/cover/20220509120337.92472-1-cw00.choi@samsung.com/
- Add tested-by tag of both Chen-Yu Tsai and Johnson Wang
- Fix some typo

Changes from v2:
: https://patchwork.kernel.org/project/linux-pm/cover/20220507150145.531864-1-cw00.choi@samsung.com/
- Drop the following patch ("PM / devfreq: passive: Update frequency when start governor")
- Move p_data->this initialization into cpufreq_passive_regiser_notifier()

Changes from v1:
: https://patchwork.kernel.org/project/linux-pm/cover/20210617060546.26933-1-cw00.choi@samsung.com/
- Rename cpu_data variable to parent_cpu_data to avoid build fail
- Use for_each_possible_cpu macro when register cpufreq transition notifier
- Add missing exception handling when cpufreq_passive_register_notifier is failed
- Keep cpufreq_policy for posible cpus instead of NR_CPU in order to avoid
  the memory waste when NR_CPU is too high.
- Add reviewed-by tag of Matthias Kaehlcke for patch1

Chanwoo Choi (3):
  PM / devfreq: Export devfreq_get_freq_range symbol within devfreq
  PM / devfreq: passive: Reduce duplicate code when passive_devfreq case
  PM / devfreq: passive: Keep cpufreq_policy for possible cpus

Saravana Kannan (1):
  PM / devfreq: Add cpu based scaling support to passive governor

 drivers/devfreq/devfreq.c          |  20 +-
 drivers/devfreq/governor.h         |  27 ++
 drivers/devfreq/governor_passive.c | 403 ++++++++++++++++++++++++-----
 include/linux/devfreq.h            |  17 +-
 4 files changed, 389 insertions(+), 78 deletions(-)

-- 
2.17.1

