Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61405510BA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238933AbiFTGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiFTGxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:53:13 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8DFF1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:53:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z11so7549938edp.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 23:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M7viZKPAV4Udgzu930yRnMV9UFvypFU/FwQw+uEjxc4=;
        b=eVmT7ZV+vM2II32DTtz5GqubTfh3OndN6nOFEooR0Kf91HSg1bUq5g6LKqo6OGrf65
         1RyBEaxsOyjajY5ncLzu2E5cFg4vjEXyqj/A/4iXxmokDVwjmlTpIyP7l64t8E1aJiIh
         Q939pmf4PKCf+YJgTzMstsfQaQNe25FUknT6U7exaNMRU4FtS9zwQh48UeCcWv7ZOe6k
         cy4Y373g0yoLzxg/Cu+r16/0U7sqYAeBe/xex5pMRDx2aTNMDyqyGZLXctR9CfEkTduc
         cwHnFhfvD2dVHwmUcDI5qK7yBGK0o4Qzbxst+rb9fkUI9CBwdrGgCrT7meKWRQsLK+sL
         /2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M7viZKPAV4Udgzu930yRnMV9UFvypFU/FwQw+uEjxc4=;
        b=sDo6ZcCRzhGoSaqN6coRPpSMZ8gm1KDaYeDcmIv2fnCrx55ux+ZT/QkVYTGq9ISIEj
         bZhyl8S9ttZyxSr19NecUw+PfiDNhkznKuSbmE74b0gl0Ir/GMsZ+WkjRW31sew7tS6I
         wblto4QGbsR4ZPUn+Lz7PiyQVvNWOd4IS5zHxBz5vaJ9km9aRVdQY4ZvChTe1DV3tZYy
         g1WeKeFDF+9DmizIRQDUNyBnimCXDoj33g9hH4BnDqYhzdnBBiiwQKApEodqyms/Y095
         bbfIrqHX8fCePPbx1MHq/QkuJTFehlg6qF1TwZtqg1j9Gyl6hyCqPfdY1ZboqJBDyten
         bUww==
X-Gm-Message-State: AJIora/GmdBlE9rT2tKLMnGjsOlcJeSNm9hm0l1x/QRN4tH2XOWdJuLM
        LNGvCAE5vhow6p3djpjpam+YxVWlZvtxjjZYZ+st8g==
X-Google-Smtp-Source: AGRyM1tX+kIwSZtiyS5mINPLo+SLQ7bV4Fy/nrzz8/+LACEiu9IMg/gg6HtQuLdC2A872rohhFpuBSFF//aG02QfXFw=
X-Received: by 2002:a05:6402:3688:b0:42d:d3ba:4725 with SMTP id
 ej8-20020a056402368800b0042dd3ba4725mr28112661edb.212.1655707991145; Sun, 19
 Jun 2022 23:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
 <1654879602-33497-4-git-send-email-john.garry@huawei.com> <303bbfad-edde-1197-679e-4a09175fb1f3@suse.de>
 <594ac0c9-a55b-bec7-77e3-a6c7e9525f6b@opensource.wdc.com>
In-Reply-To: <594ac0c9-a55b-bec7-77e3-a6c7e9525f6b@opensource.wdc.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 20 Jun 2022 08:53:00 +0200
Message-ID: <CAMGffEm8qgRzs8epMgBiJ-Ma2AGEynwXc0dSTB8k5cj2+1GhCA@mail.gmail.com>
Subject: Re: [PATCH 3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc
 + free
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Hannes Reinecke <hare@suse.de>, John Garry <john.garry@huawei.com>,
        jinpu.wang@ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajish.Koshy@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> After the patch, spinlock guarantees atomicity for both alloc and free.
>
> Not sure there is any gain from this.
+1
