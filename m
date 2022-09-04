Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA325AC806
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiIDWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiIDWlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:41:03 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAAD25286;
        Sun,  4 Sep 2022 15:41:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr9so5104860qtb.13;
        Sun, 04 Sep 2022 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=OhNVmxobKxPAOc2F8e1f6jTw4GWmQFYD9QUpKala+WE=;
        b=MJ7J/EuS/PdToE5LMrkG+v4bm/Q/uLjbiRAn2JNNz92MuUjnmBQIoMunftS0uyiu2C
         pOFEn6pHQ8e5wqtPb/8JmT5uHU8n8v1Pg6zNBsaG/TBtEaE8Ea+7BYwiA09lak2Eti61
         vdrNx4t+vY9xG5heMOHZfgKN/uNWBcrUf6ZKJ4ML0f/Eh4kMXvU0C04NFbGaMKzc9+Dr
         Y+Etc7BxIYolVEs7H0fxfYDM3AE3W4olmzSGrjxXWHo9CSt0cAYHD+IRJL9zZY3IifFo
         saFcoUxwbnkp7h6vpAnecJuVULjxhpUKkbyNRFIzxZA/IO/ugKlYGDoLMTqFJoVIG9Uh
         +gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=OhNVmxobKxPAOc2F8e1f6jTw4GWmQFYD9QUpKala+WE=;
        b=ilONP3vE9WBDanQP9ND0Yvzn4hpxhPzaQ7Bsgk52eyQ6K39ju5eoQ6PgbdFuP6wx73
         P6DZGJa9DhbhZHaTxtooDbVx0cUIQ4xzUPfUl+iO9vSFlINIRJJB30S31HJIitCVU0kc
         z6VNu1Pvftle3bO74q3tg1E1HPj9ZyRFLFPdKKb1NilEfj+SI2Qd6/TXlTHtiYUvEd3z
         xot+DUtXNrkDqkxTXkClk6NmevhF8nEe7WM28EkgVHnxytWmxVCRvjaTryOBwM+uiM6h
         HiRYktEpYlQm+KC6nQYeyz2adzzFyNSzQtI+rb4mnU6Q0w8H/h1RQuB4kfFCev0GevGm
         fZQg==
X-Gm-Message-State: ACgBeo0KJfctDmnnwS9TYafmdV/4YzIQtjwjOpVF3In4wfXy/oROODJL
        COnmWawBqXpSOEauntFIeN4bw4IflZ1zuD2U98g=
X-Google-Smtp-Source: AA6agR4YM6IeHPjVxSTenRAysMPpkF4SxpYd2mlYDCsYU8vb/QK9OW69pxuiXeEq9ZnUzUVSy7EPKPhYIM6yA+NblEE=
X-Received: by 2002:a05:622a:15c7:b0:344:5321:5874 with SMTP id
 d7-20020a05622a15c700b0034453215874mr36917890qty.506.1662331259612; Sun, 04
 Sep 2022 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsO+kB2t5QyHY-rUe76npr1m0-5JOtt8g8SiHUo34ur7Ww@mail.gmail.com>
 <87ilm3vbzq.wl-tiwai@suse.de> <875yi3froa.wl-tiwai@suse.de>
In-Reply-To: <875yi3froa.wl-tiwai@suse.de>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 5 Sep 2022 03:40:48 +0500
Message-ID: <CABXGCsMQ5H23np6fMN=58CZ6cBiHFF4WGdKdbtYLFyAAeAu5rQ@mail.gmail.com>
Subject: Re: [BUG] commit a8d302a0b77057568350fe0123e639d02dba0745 cause
 IO_PAGE_FAULT and a lot of errors
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-sound@vger.kernel.org
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

On Sun, Sep 4, 2022 at 1:51 PM Takashi Iwai <tiwai@suse.de> wrote:
> Also, please check the patch below instead of the previous one, too.
> If this one works, it'd be a better choice.
>

I compiled the kernel only with the second patch.
I confirm that patch fixed the described problem.
No new problems were noticed during the day, thanks.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

-- 
Best Regards,
Mike Gavrilov.
