Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2C552983
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 04:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344578AbiFUCqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiFUCqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 22:46:35 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D0A1C927
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:46:35 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h5so6399058ili.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 19:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=n0ZsIsM1hSR8SGvAfAtb7KID3gwNumol7V8bVZdmf0c=;
        b=EZZD1iIODzbzmjZQH98fxiXZR/QSLe1jSJpBpvZhmHGUL35fiA9n+Q763NWlgMS1sR
         jb2K+13zcsA0FClskwO/JXlts6b8KH/TnE1BKXF/TOxwcntXz0CtFSmiKZDjBQRvGGCg
         bpIXVtcMfX9DjxaE1xFQpyMpjvwaFYivZNhRlaNk/QfYEZ5+KNp6VAfJArtUJKT6rAj+
         uJDGuqe32rQQuimSePJLRap0K0VvOqATjUpMIoi2m/sdb942Co1voe0//FXm+x4kcC+M
         7fnJrgb+ErkS3O+VHB7dYMRlsm4RL/HURqBhbhKrPe7a9Tw3Os5Wzzo3m3ZztC/bLq9y
         3JeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=n0ZsIsM1hSR8SGvAfAtb7KID3gwNumol7V8bVZdmf0c=;
        b=ef2gkkomu+A6hFZUM6R4i7VuK2Mos5U6sOyPRbIWi2/ra8k3CMoiEcovmDK86qYQY8
         Y+IBLavN1P3ig9aEEIn0nx/XlwIRaSgbh1tQ9NaCgZ9icz+76E7UvG/Z792gCj1YIG6j
         QePyhH89XMWrRJ4/KuPLWkgnSAAdG9sWrp2EBs33V/rbZFyAzOIrvAMcj3K3NTP3pkIy
         hf+CDReY5PdS+2pNvrQz48OtZW+dg2snQyr/K+6l5s57u8IhYeKBrfAHZc6vQkGtgesP
         HU3Kz0nh5Uv6oP38mOZIT06hFy38t61Bb7JuAWubQd5PatRVMX9hP4cU5vZzZ0Sn5s8o
         6Xqg==
X-Gm-Message-State: AJIora8LLdIhVyZw+eanz0teZtcT17k757WE7V7LY5MY9TlG9RJLg9CP
        khP+SWBORjLyS5gXHlKG/t3Ep+29GHEqwVCMSfg=
X-Google-Smtp-Source: AGRyM1uOcgAoNIHrtAKB0jOSkrlpxkoN+kKY6aQBqLn5XVcXMu7pRmUCaGexdfqf+YEivorkJA5UxwK8ajAbFJujePM=
X-Received: by 2002:a05:6e02:17ca:b0:2d3:e6bf:7724 with SMTP id
 z10-20020a056e0217ca00b002d3e6bf7724mr15059355ilu.312.1655779594570; Mon, 20
 Jun 2022 19:46:34 -0700 (PDT)
MIME-Version: 1.0
From:   noman pouigt <variksla@gmail.com>
Date:   Mon, 20 Jun 2022 19:46:23 -0700
Message-ID: <CAES_P+_aC4cHMB3Tn0pz13_gKCpXs=efeae2JBvEPOK5zidYnA@mail.gmail.com>
Subject: ASoC: SOF: Race condition in ipc.c
To:     Mark Brown <broonie@kernel.org>, liam.r.girdwood@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org, sound-open-firmware@alsa-project.org,
        yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com,
        peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, rander.wang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

I have borrowed part of SOF architecture for my own DSP
framework development as the memory on the DSP is
extremely small and wouldn't be able to support SOF.

Currently I am running into a race condition as below:

CPU                                            DSP
PCM_TRIGGER_START
sof_ipc_send_msg ---->

                                      <------Immediate ACK
ipc3_wait_tx_done
(wait_event_timeout)
                                      <------ POSITION update

snd_pcm_period_elapsed


As you can see TRIGGER_START didn't even finish
and waiting for it to complete in ipc3_wait_tx_done
function. However, before it could complete the position
interrupt was issued which results in calling period_elapsed
function.

In order to fix this I assume below is called in SOF framework:
schedule_work(&spcm->stream[substream->stream].period_elapsed_work);

How is this design working? If the interrupt is coming too fast
from the DSP than the associated function with this schedule_work
will not get called as the scheduler will not get time to schedule the
workqueue and elapsed function will not be called thereby not increasing
the hw_ptr. How is the flow control for data transfer achieved?

I am facing the above problem in my design.

I am wondering if I can simply add one more IPC command(don't call
wait_event_interruptible for this) after TRIGGER_START to start the
streaming.This way schedule_work for updating period_elapsed function
can be avoided and it can be called in an interrupt context.

Thanks,
Variksla
