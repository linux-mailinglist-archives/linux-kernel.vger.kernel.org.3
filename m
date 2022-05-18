Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB63052B1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 07:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiERE5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 00:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiERE5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 00:57:01 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C74133E;
        Tue, 17 May 2022 21:56:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q76so1109403pgq.10;
        Tue, 17 May 2022 21:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OXwNg6zBuwLIgqpUW58oS5+90CnUYRCpLw+6qbxds1g=;
        b=Pkw1rQ4Xhvyrr52qbpPjgh5k1O0mmchEIiD7A/Mpsl27TWjPxI5xlEQr7EUzVR9uqY
         YrYBStF7Md6CyLa3geIp2w2QB2MY/Z8JhvkkoUsUpd7SLPX2dIlMBEm8PnPplTxcc7Jt
         cBMj7Dv3px/oqD97mMiuMUvcEgpPeC3TitNwX3uBG1bcGQipWChbnv9z/JNOYHswa9oD
         gbMptomEe5IfKC8fE1VBT88R8IMfo67nPQhYIJYFm2dj00//84oNtZycCywAVfW4tpAq
         aUjAlPgr1qFdAbYec0jgI/nTSzS4DNsAJTe54h/EQy6bMQCkuYetjPJLvnB/nufo80ii
         aKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OXwNg6zBuwLIgqpUW58oS5+90CnUYRCpLw+6qbxds1g=;
        b=xPqxLOcAhiE41CcagUZS7qHswcySYIBzSEKWlxklvvYQ7z9IOj185JQ00BZBj1Ro8c
         Oau49MIg4k98ZDriiBJgBD4vWNHI1/DZNb7Q52yAN1bQytDvDhILFPNAbmxDN1nTHQEB
         31E6m/a8o5+4wYmzKV4/wyvQpYw1UWReLG7SmpzNqJ2i6REZo+d2t+pBTu8G73S7Gf0r
         zDx1IA2BxEJP4gRi78xtJp9MyuTTkduuQE6AHzLcn0CUG6yExfSG5K2ho1pwAhmfkLV8
         JLkRhyuq2RQZskhesMaBhWWBAOeh13wkWqVMyN9BQ4J875gxQDW56WQuiHarac/+BF2W
         4+OA==
X-Gm-Message-State: AOAM530jmbMudirVVZJm05EzfVb5QMN9jq2ao1KktYyFPHjrty8nvOfl
        7TVU/VoZ5/JJTLltBYYUqdk=
X-Google-Smtp-Source: ABdhPJwzDCFCoNaq5X0owAFYSMVw2ftZc9zIveU3UI2H7GUWXJ7mICUZXxl2MnUySTStNtTv+DjVXg==
X-Received: by 2002:a05:6a00:e8e:b0:4fa:a52f:59cf with SMTP id bo14-20020a056a000e8e00b004faa52f59cfmr25885877pfb.84.1652849819215;
        Tue, 17 May 2022 21:56:59 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:556b:348:b181:320f])
        by smtp.gmail.com with ESMTPSA id z9-20020a1709027e8900b0015eaa9aee50sm498725pla.202.2022.05.17.21.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 21:56:58 -0700 (PDT)
Date:   Tue, 17 May 2022 21:56:55 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc:     linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/vmmouse: Add vmmouse_reset() function to disable
 vmmouse before entering suspend mode
Message-ID: <YoR8l/UK8rXS1F8A@google.com>
References: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322021046.1087954-1-zhouzongmin@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 10:10:46AM +0800, Zongmin Zhou wrote:
> Details:
> When I use VirtualPS/2 VMMouse on virtual machine,There will be an error message after resume from suspend mode.
> like below:
> psmouse serio1: vmmouse: Unable to re-enable mouse when reconnecting, err: -6
> And vmmouse will be unusable，so have to do full rescan to find a another driver to use for the port.
> 
> This error is due to QEMU still generate PS2 events to notify kernel driver to read from queue,
> but kernel can't process the data in suspend mode, resulting a surge of s->nb_queue value,
> which ultimately led to an error getting VMMOUSE_VERSION_ID after resume.
> 
> Test scenario:
> 1)virtual machine started with qemu command "vmport=on",it will use VirtualPS/2 VMMouse
> 2)click suspend botton to enter suspend mode
> 3)resume and will get the error message from dmesg
> 
> Fixed by:
> Disabling the vmmouse in its reset handler,It will notify qemu to stop vmmouse and remove handler.
> 
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>

Applied, thank you.

-- 
Dmitry
