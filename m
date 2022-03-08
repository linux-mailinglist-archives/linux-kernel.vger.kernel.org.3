Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49024D1FDA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 19:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238794AbiCHSOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 13:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348973AbiCHSOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 13:14:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16C83B3D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 10:13:33 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id q11so17791038pln.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qZoIySMENoA9ziiqo0hyYo14ox8nz/iNMlsEajYbI3I=;
        b=c0xmYOIdDm9vlz0qMUc/V0ZlfmoCH8U6Qj/f2i+6Bx2tNBVy0JjwHErobuvQb1eqzk
         yCVl56gnZqJcsYOUlZrA3V0/t1W9nuycz+/Cn9uA36GLmvMHaPHAIfclW4FnEZ8nxbKy
         cdpBBG1jY5qsliF5gb1aRSgE7HJ5WP2nl/AC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qZoIySMENoA9ziiqo0hyYo14ox8nz/iNMlsEajYbI3I=;
        b=f8dpVZDmtUEVC3i835GbhfygkpLAKkcV8PY/pBtJ4u+38HtMvfSI/uIVRQtHKEqKT+
         IxN2jgJpg0ocUsyUSRcmhbXZdlljCEjr5f9Ts+96afou8Cn6Xh9qp0KTThu++Z7oSYxR
         UsTpOukuREq3d/JiRo3WlUSR7E+tbMpk2n4WkhaeyIW6IBYFMkcKnA6ud5kOqJCCTAKx
         8yQdlYIUjW7+yMw2SA5pYiUhHiKlG8KHnSrfU6YQ7+Co1goB/IHoZcqHrKH4pupmLiUj
         zlJcOuRytT30aLoLHEgo6/bFDtcJnqs+3QD0ZXm14n3inzmkiQVqpPvbmORcIN7BJ2HU
         3aRQ==
X-Gm-Message-State: AOAM530W46Deg+dCmevBbA1dRLZzDK1EzdeHXf6hR9i24JAeLcSH3yaY
        aDRb3c6vyTWuWtxbCGkvmV2uOk42rHSL1A==
X-Google-Smtp-Source: ABdhPJwilIhINV2C1yNo+ncdU78v1nV0cNUJh9IJkLlXw2PDwEPLXQQndLofRT6SMzd4daBG3RLotA==
X-Received: by 2002:a17:90b:4b0d:b0:1bc:4cdb:ebe3 with SMTP id lx13-20020a17090b4b0d00b001bc4cdbebe3mr6064371pjb.176.1646763213333;
        Tue, 08 Mar 2022 10:13:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:b3e3:a188:cbfc:3a0e])
        by smtp.gmail.com with ESMTPSA id a15-20020a637f0f000000b00372e075b2efsm16003944pgd.30.2022.03.08.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 10:13:32 -0800 (PST)
Date:   Tue, 8 Mar 2022 10:13:30 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Youghandhar Chintala <youghand@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, pillair@codeaurora.org,
        dianders@chromium.org, kuabhs@chromium.org, mpubbise@codeaurora.org
Subject: Re: [PATCH v5 0/2] mac80211: Trigger disconnect for STA during
 target hardware restart
Message-ID: <Yiecyl7Dd6AXJhN+@google.com>
References: <20220308115325.5246-1-youghand@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308115325.5246-1-youghand@codeaurora.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 05:23:23PM +0530, Youghandhar Chintala wrote:
> Currently in case of target hardware restart ,we just reconfig and
> re-enable the security keys and enable the network queues to start
> data traffic back from where it was interrupted.
> 
> Many ath10k wifi chipsets have sequence numbers for the data
> packets assigned by firmware and the mac sequence number will
> restart from zero after target hardware restart leading to mismatch
> in the sequence number expected by the remote peer vs the sequence
> number of the frame sent by the target firmware.
> 
> This mismatch in sequence number will cause out-of-order packets
> on the remote peer and all the frames sent by the device are dropped
> until we reach the sequence number which was sent before we restarted
> the target hardware
> 
> In order to fix this, we trigger a disconnect in case of hardware
> restart. After this there will be a fresh connection and thereby
> avoiding the dropping of frames by remote peer.
> 
> The right fix would be to pull the entire data path into the host
> which is not feasible or would need lots of complex/inefficient
> datapath changes.
> 
> ---
> Changes from v3:
> - Fixed commit text errors
> - Remove excess space in "hardware  restart"
> - Removed blank line between the function description and the arguments

For whatever it's worth, the series looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
