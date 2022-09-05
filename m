Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D785AD394
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 15:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiIENPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 09:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbiIENPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 09:15:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20A13DBFB
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 06:15:40 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id az27so11334761wrb.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 06:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=x+z5fbgK5rWlFLrQ0q/oa0BmwbXh9sKksymdTFC7GMQ=;
        b=F1x+ph1oLUQWORqFZ+6iU5G/jt2WQgwrWWWyebsIQKcW+9UOxdsIIUQypDzGGRcoMi
         j05s3YxGptvw40x7s2JOAozNSdraSyG7GmWotGKU+PpHVJr8IqIsmxfo8jrHiwA3SH2U
         kPhrec/LkEbAmsOxdyGzXrm5disk9kaS4ChhnspXR6U4QEPRGUaqpx7lAXEnA54apaK8
         obP2VMs9Gisccz6V84XLu+YYfLp3yTHNAx8tO1JDXd/vYBqcGQWYbQVji33jodksCizB
         elU37YU0TvQb4NnWJjOV6PWYh7cyuOlx/bHenFczAjoU7wkT9kiJ67sAnF4TNIdW/281
         DsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=x+z5fbgK5rWlFLrQ0q/oa0BmwbXh9sKksymdTFC7GMQ=;
        b=iC9K75Cz5TFHbLitsJzxuYvETvUaLuRoACQzSn1SPQvuwuIoHriQ96k/I1V82FpCDv
         hbjj3KX8qe0VMJrTLbdkgZXLpRFiWoKVdQvfwwuhofoyQlxxYBlPNf4UguYtvwKarMa/
         da+aoKnOT4OEFNya/PxrbQWuYXpRqMAe9lhnrWLrIl5lwQ55MbUBCm2Y/L36qX+Qyk1+
         jnTKXHZw5FdBalf/BLnQWzuyEb7dJ8QJA7Rb+rxYxOP2Uucexln2nGOosZVzBzdOBl4Y
         OdtJBZnxKyoyv0Wc6TmJjwZEdV96yzbZS/2ITYfftFsmmDf2Gb+/2fezw1db/qKPomVm
         MocQ==
X-Gm-Message-State: ACgBeo3skhJEF3qO9x1oY9efCh6tA3zBwpRIZIYnJk9ZyYpaCFAUCOIG
        WPUeC/fVz23Zb14WxA5rq3FKvgrPpBr18705KSKruh0EeIE=
X-Google-Smtp-Source: AA6agR4OHk0dWrF3EDRI1FChnBvUyFqcofwqBz5m92F++Rw8GkiS+bAka5b6ma0tgWR/0cMK4A50cXKDzEYmb3n1lV0=
X-Received: by 2002:a5d:6388:0:b0:228:c792:aabe with SMTP id
 p8-20020a5d6388000000b00228c792aabemr1064303wru.689.1662383738519; Mon, 05
 Sep 2022 06:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <1662373788-19561-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1662373788-19561-1-git-send-email-shengjiu.wang@nxp.com>
From:   Nicolin Chen <nicoleotsuka@gmail.com>
Date:   Mon, 5 Sep 2022 06:15:27 -0700
Message-ID: <CAGoOwPQomcnO5dhkT9DBynwJo8LfVvuuwj5AYNpv0KhAGSWLEw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: Add initialization finishing check in
 runtime resume
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

On Mon, Sep 5, 2022 at 3:47 AM Shengjiu Wang <shengjiu.wang@nxp.com> wrote:
> @@ -1295,6 +1301,17 @@ static int fsl_asrc_runtime_resume(struct device *dev)
>         regmap_update_bits(asrc->regmap, REG_ASRCTR,
>                            ASRCTR_ASRCEi_ALL_MASK, asrctr);
>
> +       /* Wait for status of initialization for every enabled pairs */
> +       do {
> +               udelay(5);
> +               regmap_read(asrc->regmap, REG_ASRCFG, &reg);
> +               reg = (reg >> ASRCFG_INIRQi_SHIFT(0)) & 0x7;
> +       } while ((reg != ((asrctr >> ASRCTR_ASRCEi_SHIFT(0)) & 0x7)) && --retry);
> +
> +       /* FIXME: Doesn't treat initialization timeout as error */
> +       if (!retry)
> +               dev_warn(dev, "initialization isn't finished\n");

Any reason why not just dev_err?
