Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4050E701
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 19:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbiDYRZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 13:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiDYRZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:25:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8415D40E40
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:21:56 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a11so4177961pff.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KT5fi63ozoeP2wgW9QoaoX7sMxApWUElWOAK6Kp+zQc=;
        b=OobYMCoXgSiP2AxcFbw0t/VqyqEQWOu++/jLTLUMHdgst1dMB9oOBVWhNTL1NW/W3q
         vZKPDj0KPORzseCkhVLgovr4lZq1vCXHkhpnHegjZPAr3kZH4sZAXj5EPFLUbeWEurxV
         QlRrHodOko+ps8HFRb9uXHfObwiw1INdQ4JvzN5Ah/Qakzl0cD4n35XYqPr64nxpcOcb
         nKF1WH+hBsDzjNhlQjB9EJIO5Zj1Sm02y0PdquMd6pAZS71h5KCLs+pECnbzgkR1uQid
         ZNcYQtpWiEC6AcX/KNCHAdPQugpP2Lvk2czvjp2wmB+0pLjiMFv4jyi9SZfpMOnhDicE
         iyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KT5fi63ozoeP2wgW9QoaoX7sMxApWUElWOAK6Kp+zQc=;
        b=qNeqHIGaCUe4Yq+/AYBgqesjaEBRcL0OFLo44xrQ4Yy3RgSZqIh5jS516W6PAMTtH8
         oH67zKVXi+qayZ5C/bHQIF5sDGP82ndTg1Ys+2cu+8Qu4bRk4RYAKp4mJqBDBiLxmGgD
         /O0J1AnBP3VGurbCs9mS//CjKVlCycQ88yw1A82Qtpw7L6rL7E1JISj1ijAKH9ZXi87L
         zABKu3RvqXxVwUR42OEWHfkLSTnO2ipp5YoczwJPyvhTwI93WvjcKmpqh0C7vF/aHkxK
         lW0UAQYH+EJt97irELNG4dHmZTeimDOU7JK5ctS8rJdOEKEzZYgcnvrZuk2nc0mbs6Rd
         I8TA==
X-Gm-Message-State: AOAM530WmKmCvK6rpJ4Z2BMwyPZVhN88ytwXHhjIg1d2ra/eaJ4p+Zmr
        hQWFnQKlv5HjTD1KzUwOzKk=
X-Google-Smtp-Source: ABdhPJzubSG9msXx3WTpPuvCVw2GvWI+MLBo2EIP7EogKkY+yQnWeSCxXyV3Su1gQw0hFObsiWpqHQ==
X-Received: by 2002:a63:224f:0:b0:399:4a1a:b01f with SMTP id t15-20020a63224f000000b003994a1ab01fmr16153268pgm.123.1650907315638;
        Mon, 25 Apr 2022 10:21:55 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2e9])
        by smtp.gmail.com with ESMTPSA id w187-20020a6230c4000000b00505cde77826sm11913760pfw.159.2022.04.25.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:21:54 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Apr 2022 07:21:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YmbYsI0wkH01u5M5@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <YmLfxHcekrr89IFl@slm.duckdns.org>
 <f2ca9d19-023f-76d9-5c76-6f08ccfbe348@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2ca9d19-023f-76d9-5c76-6f08ccfbe348@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Apr 23, 2022 at 06:49:49PM +1000, Imran Khan wrote:
> Thanks again for reviewing this and I agree with your suggestion. So far
> most of the concerns have been around usage of kernfs_rwsem and those
> can be addressed independent of first 5 (even first 7 )changes here.
> Just one question in this regard, should I send the new patch set
> (addressing open_file_mutex and list conversion) as a separate patch set
> or should I sent it as v9 of ongoing change set. I guess first option is
> better but thought of confirming once before proceeding.

Either way is okay but I like the first one too. Let's break it up to
smaller pieces so that we can make progress piece by piece.

Thanks.

-- 
tejun
