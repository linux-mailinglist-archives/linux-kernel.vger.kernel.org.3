Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75354E1FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 05:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbiCUE7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 00:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbiCUE7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 00:59:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD636AA7F;
        Sun, 20 Mar 2022 21:57:38 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j23so1342234pll.4;
        Sun, 20 Mar 2022 21:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLwShMZpFVnttuqvEbdrkmmsS2bGXBfGBiSI2Uo2yco=;
        b=TpTUiczvhMBuZwTGPVhmDTRUbN1/0RAcJBgl6ZMwoyjWAUjV/T1yttZ2XtExcNES37
         ot9N1RZraiX1CofYXH4B/3oIFhyfe4CRUdbcuuhMyq9AFSaiZAgBgFsbmt16ax9XlaFM
         6vcb7QiKjmFJc9qWFMyvJFSHJrNv5v4Bwr0osGJDX0aLvcE1zU8uhAJjyOuy9i0+B2MA
         hwoL9xiGV6NFNSlnBz6X7lY0YEZuPrhcSlcvLTQjURne87KF3GIZn37VUGKyyWfBGjIB
         /7D8tVgVYaodGzRq9aCIO9+/A2W3hnngLS9kGhhFDUR13nDf7BVRY0fkmOEeeQokz3HF
         PK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLwShMZpFVnttuqvEbdrkmmsS2bGXBfGBiSI2Uo2yco=;
        b=Sk8MLDlibz40AlwRjs+dWLz7PoMoemrcXJju0nUviUkYPltdh+QDr6atoWBs2n4XRs
         dQUALcSvYCTeh+RNpjZPekZqwZ2vcG8+5mIR8I22uhoAzyKCiJdtOvCUd0V+xyPvyFFc
         6v+kdPbD/yogjxrKlNitEwNIp7hwvTqHFEHiLyzZgGBIHdfSmBnUozMeJuTLlBOtYPoz
         QJaLvLkyHTYI+VG+tb7upJwn/vc6wlzdW77OBoCLO3v+kdrOqoMtg86vUvzR+VXDAeUH
         OPAa5B9gj4qjrxj/XAbQYdzTsJ9apdccLTcFjIMHTw/3fZaiTNDVqg5h/YJIPQ/W26M9
         TSmA==
X-Gm-Message-State: AOAM531RaSXAN1bcZo0bBRZU/A/8NR734UlQBH+xuR7NYmcVvgujs07z
        nde/Kq+fnkZ/UDL9VOJ7wZk=
X-Google-Smtp-Source: ABdhPJy2QKuXkIMIpb6OZyTCemvsSgDY73bTi2uKa1E5rbRhlkD5fLusyOwSbP8pyLxk6aQU3aRkYA==
X-Received: by 2002:a17:90b:3807:b0:1bf:6c8e:f9b7 with SMTP id mq7-20020a17090b380700b001bf6c8ef9b7mr24357499pjb.16.1647838657418;
        Sun, 20 Mar 2022 21:57:37 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:31f6:c8f1:6f10:b2ec])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm13304028pgb.73.2022.03.20.21.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 21:57:36 -0700 (PDT)
Date:   Sun, 20 Mar 2022 21:57:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: fix reference leak in stmfts_input_open
Message-ID: <YjgFvv5uVC42J1aY@google.com>
References: <20220317131604.53538-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317131604.53538-1-zhengyongjun3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:16:04PM +0000, Zheng Yongjun wrote:
> pm_runtime_get_sync() will increment pm usage counter even it
> failed. Forgetting to call pm_runtime_put_noidle will result
> in reference leak in stmfts_input_open, so we should fix it.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied, thank you.

-- 
Dmitry
