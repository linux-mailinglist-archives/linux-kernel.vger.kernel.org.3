Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B988F50AD75
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443203AbiDVByz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443188AbiDVByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:54:54 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827D49F2E;
        Thu, 21 Apr 2022 18:52:01 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b189so4894362qkf.11;
        Thu, 21 Apr 2022 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HEk4hTPFMEeLKcwxeGCL5ytEG36OtI/K5sQN2DgY24Y=;
        b=JSVRj4AOjF0HCVL4210OnZVZbYdLF+Z7jZcRKiZvy34I8085TTGWlh5GCu6+g0+rv8
         SW9RY76mIarinP/WJ4fUbmbICVE1gY5s7MZIxshMZwrnyEpHzit9tLOW2gPieqx4uJpz
         G+2rcTaAFXvU/SDOlKymncb+D4W3sIi/vwKoy8brkS5OkMPQmEBOL0Ackgys0HD6BezI
         893XX97m9yBsRjxgtPZf43KDILd3uxRNMQpOqWV81MgYEkbKlMxciN8K6tsiBbFh3YyR
         cv1ouSB3yopZZ5GEROq/KL7ZWd3W0DlLBEpW/Xfi6yhSq6YdlRJXOtAyk7zMV8ey0fsP
         XiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HEk4hTPFMEeLKcwxeGCL5ytEG36OtI/K5sQN2DgY24Y=;
        b=jb3kv+Y5hmjTAv1e73OIMBD1rxK82GitUive4EUJFr/Ip6ETkPrlnuCJw5gohIW6Fs
         ceebpLquA//9sbFM/3tfVU0NQ9N9COVIJkVf9uWR8rvSCdnRpXlxL1/OoNOK7X4AyPAx
         KPKox+hzWMdVliyn91Hd+MMOmwKpPZGu1dbtwfJGa2sRpXzizmM8x5BaK86La2RoHyMY
         NUToxIGE5zrZreMRVnNX+RLdTr7IXzPW5a6ciet1AAuCYwLovqvfuVQVdWFZ2Rpz7QEq
         54cEHGd8m/dtjIm4SM54rKCqjzlUzzsdOC3gCaU9AoKAu7yrcUYPdZB7Dgi6US4lHwkI
         xeBg==
X-Gm-Message-State: AOAM531fF7s9f3u9KpLjytWEnXG9RmLff2SgNgKd28BpdTspbaW6UXyH
        jIjTAZvQuWd+nscD6K04WK0=
X-Google-Smtp-Source: ABdhPJyNi8abti8ee2LE2VUFA0I3wNyi69krbQCXohnAOeqaoYKYs2yuQybCM20vPfC3T7OpQb5tsw==
X-Received: by 2002:a05:620a:469e:b0:69e:d1d8:6294 with SMTP id bq30-20020a05620a469e00b0069ed1d86294mr1442574qkb.36.1650592320407;
        Thu, 21 Apr 2022 18:52:00 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm489370qtj.28.2022.04.21.18.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 18:51:59 -0700 (PDT)
From:   Lv Ruyi <cgel.zte@gmail.com>
X-Google-Original-From: Lv Ruyi <lv.ruyi@zte.com.cn>
To:     hverkuil-cisco@xs4all.nl
Cc:     cgel.zte@gmail.com, eagle.zhou@nxp.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        lv.ruyi@zte.com.cn, mchehab@kernel.org, ming.qian@nxp.com,
        shijie.qin@nxp.com, zealci@zte.com.cn
Subject: Re: [PATCH] media: amphion: fix error check return value of debugfs_create_file()
Date:   Fri, 22 Apr 2022 01:51:53 +0000
Message-Id: <20220422015153.2729378-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <291b141f-9f58-54c6-0005-fec0a9335dba@xs4all.nl>
References: <291b141f-9f58-54c6-0005-fec0a9335dba@xs4all.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice, I will send v2 ASAP.

Thanks
Lv Ruyi
