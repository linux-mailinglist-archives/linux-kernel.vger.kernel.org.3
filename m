Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62D25915F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiHLT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238120AbiHLT2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 15:28:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2EB08AC;
        Fri, 12 Aug 2022 12:28:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p8so1536771plq.13;
        Fri, 12 Aug 2022 12:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=IaNDAdEa8hgXhA9slqB1hEbULevRfy/CuIByo7fB7oY=;
        b=HLSm97rrOLYJkzPX2w6QgFUDvZAlVyraM1Cdtc6CnudfXDGFGGSC6oP9jpu1K5FU9y
         jr9ifGkldw6NkuannS9dSFrNzyYUzifTOx83mmUeATi0/1yzcjnKoUJQQCYdGNPqITB7
         B78KVzOFbVwHSu9HOeACSLpEpQsTA3KXkmMzCOga9JsEGadJfEjdsGuDIWWKtpKtpC58
         YHRYgvxX5YcqeedHn1YHQZn6d0HqRABlOr7PbKRecywam6pic7QV9bsgLV4ZtlTXWhD+
         uuMwPWLT+NK87kyzdj6ytGOTT1wIgnO3hcUJUPSnPx+5WpyUfpjxwww4ARJGRVw5Rn54
         KQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=IaNDAdEa8hgXhA9slqB1hEbULevRfy/CuIByo7fB7oY=;
        b=qBawCP+eRSHxWEx4HS0YIq6Qvpb2iN3ZOp9QYmIyTTOOthKFIZyh0jltqvnOlTi/Mh
         jx1s2L61MIAJ85iuSicrH6ZuzKzITOxmeLWT50mJ2HYFK6Dbk4zjUKyiW2duuS20JGgA
         9t5URMsBefWoWszlVTVaPtCkZEXMsJvAlmfW3xKDSFgeCjJ4UJKAxlgtDZ6svw2sI+ie
         pG+W41Mr8PnzGnTGXSZnxUhszDW/Fxn9lElDLeZdbxuJepfvqZBz0Xns0K8Xe7N66Jwy
         XmyxjZmlp0mTIWq85yUIwNTC8dpWSB8Ste4XazxvPaYc1DpPMKZe1cnSVkc19TLbFCjQ
         HLTA==
X-Gm-Message-State: ACgBeo2JMHSgehhkl9rYm3mx2LCGe/ABNmmAy+1h2YEBkk+nmigCyvLg
        UnqUX8if3KqSk58Ny7lrMtE=
X-Google-Smtp-Source: AA6agR7Y6iCDD7AR93KBVw18z7gK/7WjC04/p/OasvAPHPOCIhX6lGMi+tKOCzhW72UlXFqTP/Qz7A==
X-Received: by 2002:a17:902:d484:b0:171:3cbc:7c6 with SMTP id c4-20020a170902d48400b001713cbc07c6mr5423597plg.85.1660332502216;
        Fri, 12 Aug 2022 12:28:22 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:eb15:868d:43:d73a])
        by smtp.gmail.com with ESMTPSA id b4-20020a6567c4000000b0040dd052ab11sm1691136pgs.58.2022.08.12.12.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 12:28:21 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:28:18 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     margeyang <marge.yang@synaptics.corp-partner.google.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, benjamin.tissoires@redhat.com,
        marge.yang@tw.synaptics.com, derek.cheng@tw.synaptics.com,
        vincent.huang@tw.synaptics.com
Subject: Re: [PATCH V2] Input: synaptics-rmi4 - filter incomplete relative
 packet.
Message-ID: <Yvap0uh1U81gqy6J@google.com>
References: <1660293805-16053-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1660293805-16053-1-git-send-email-marge.yang@synaptics.corp-partner.google.com>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marge,

On Fri, Aug 12, 2022 at 04:43:25PM +0800, margeyang wrote:
> From: Marge Yang <marge.yang@synaptics.corp-partner.google.com>
> 
> RMI4 F03 supports the Stick function,
> it's designed to support relative packet.
> This patch supports the following case.
> When relative packet can't be reported completely,
> it may miss one byte or two byte.
> New Synaptics firmware will report PARITY error.
> When timeout error or parity error happens,
> RMI4 driver will sends 0xFE command and
> ask FW to Re-send stick packet again.

My understanding is that F03 is intended to be a pass-through mechanism
for PS/2-compatible devices. In that spirit all protocol handling and
validation should happen in psmouse driver that attaches to a serio port
provided by F03.

Historically we did not pay attention to parity and frame errors for
PS/2 mice/touchpads (and for keyboards on x86) but we coudl add such
code there. Do we actually observe this with RMI devices? Can RMI
firmware handle this better instead?

Thanks.

-- 
Dmitry
