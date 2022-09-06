Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5045AE4C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiIFJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbiIFJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:50:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C7678239
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 02:50:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id az27so14584932wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 02:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=r+ousdY1tGkO/yzh1u+RImPQAzXSy0HohJCLKxybiYk=;
        b=XJXm3+AWkaScI7PxCvoQ855MRL/3gU+oVmXA+TmaNSnrGCkp0lfnYMcUhmEa4QvBZ+
         sYaVm+qnefpABDMbdJrRDdni0Eh99VOQtMWuBGbRav13JXoztc+hfhLMaFjP8vvKQu54
         HPlkuCHjYQqAVn4ZUcS3oLedNX/SJVn8BA6ScFhLkoSk7xuCATff5Px1s+0cJDwOypE9
         aeCEGxq8ZEKZMvQG2QmfQd+hJsGRS23M3vkDrxmLEBy2IhYuHDOKnJqwq7KxWQ2futFG
         UoK/v7u/PlffiLMY82Bk6E+/SLzjX+ot28+yAWGgalHmUmRxF+byLXHYLITxie5Y85IL
         8+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r+ousdY1tGkO/yzh1u+RImPQAzXSy0HohJCLKxybiYk=;
        b=hGu3ZUh2P3CN7IwRBfBdxdarV9ikmOYiGIzy+ITDWijc6ZJ+l60OaIzsZBIjvaumSW
         +r77EsHBa+SMubZvgrKFMJIGHDQ+LS/+uFt1ZpRkObVJg0Y1Ve/V8SZ46hhyMKTzqass
         iQSUoS48ArQzHkEldgdhO8ApQ7Ti8pLN6/wXw/FUMFrrubpAprl8W4U7ep8YgwVwiU68
         3QfKbZUgLwIDf1Yo1X3JZU89HLwDPBblHCGIK3WCcDzWwZqcqoaMfTuA8p0qCTJ6MmhL
         nXvjKMPm8RcUkb82eXD71+yvkPkke/NRNAyvDyu/2DfP/KFgQLsQ2NZtNvtYH9kYOa9G
         RakA==
X-Gm-Message-State: ACgBeo0SK+3xff2xLxO7dhBWGwIfKlNX0cXashqjlCa3Zv78pd2tNH4n
        ZHUHxHQRfwpXlLmf8IIq84+hI78ctRZT9WftAAs=
X-Google-Smtp-Source: AA6agR7mPLP6wpNPjaOIzvnihjyEffacKop3Imfj0A1xsiYyYOOCWztLYg9Z3U3CKn5RbQNjZJyY/3sA6fQgEUOUrgU=
X-Received: by 2002:a05:6000:168e:b0:220:87da:c3e4 with SMTP id
 y14-20020a056000168e00b0022087dac3e4mr25983316wrd.559.1662457834879; Tue, 06
 Sep 2022 02:50:34 -0700 (PDT)
MIME-Version: 1.0
References: <1662373788-19561-1-git-send-email-shengjiu.wang@nxp.com>
 <CAGoOwPQomcnO5dhkT9DBynwJo8LfVvuuwj5AYNpv0KhAGSWLEw@mail.gmail.com> <CAA+D8APOL1Qx0fAhyajXXzh0_tqEmDJoDBh3Xgo6uYNhV0usBw@mail.gmail.com>
In-Reply-To: <CAA+D8APOL1Qx0fAhyajXXzh0_tqEmDJoDBh3Xgo6uYNhV0usBw@mail.gmail.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Tue, 6 Sep 2022 02:50:23 -0700
Message-ID: <CAGoOwPQfkT2ptdt6mBTAgPfN0NOoR4KfdLE9B2AoL+Qn6bWdFw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add initialization finishing check in
 runtime resume
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, Sep 5, 2022 at 6:54 PM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:

>> > +       /* Wait for status of initialization for every enabled pairs */
>> > +       do {
>> > +               udelay(5);
>> > +               regmap_read(asrc->regmap, REG_ASRCFG, &reg);
>> > +               reg = (reg >> ASRCFG_INIRQi_SHIFT(0)) & 0x7;
>> > +       } while ((reg != ((asrctr >> ASRCTR_ASRCEi_SHIFT(0)) & 0x7)) && --retry);
>> > +
>> > +       /* FIXME: Doesn't treat initialization timeout as error */
>> > +       if (!retry)
>> > +               dev_warn(dev, "initialization isn't finished\n");
>>
>> Any reason why not just dev_err?
>
> Just hesitate to use dev_err. if use dev_err, then should return an error.
> May one of the pairs is finished, it still can continue.

Makes sense. In that case, why "FIXME" :)
