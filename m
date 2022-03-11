Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4B4D5D17
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiCKIPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 03:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCKIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:15:27 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA44910215A;
        Fri, 11 Mar 2022 00:14:23 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id r2so535801ilh.0;
        Fri, 11 Mar 2022 00:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1StdIpP++L/cSd0BuBsm+61d7O3sGA63AK7KCYffZc=;
        b=E19cfkAJlfvdqwjJBMHqmhNI9jywVOOft5TcI/3R6WffQizzclTOkgyJ7cprWNEffb
         Wu0JPCiBkFyytFgjmRq+XqpljW7PDDb+F2r53sXYW3BmLZeUmZav9sQY/M6qUPBmSZO/
         Irpp00aVkrwLAEYWWjSbY+IuyUoBbHVJHuDu9GtgmrBdFt2Z+42M5Rofs2E5nU65vqd4
         x8tFXYr1cqP8FK13XzBPUEgs8D1KDCMNifU6iHNHkYJTwE8sF+1/ZUg7gteTgTSonhws
         13QCpZBe1KiAjFrYSi9GlPpXIFComgzp2YHle9qLOySygkL2v2JBC+22Q9l9pVaSY0Fx
         jngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b1StdIpP++L/cSd0BuBsm+61d7O3sGA63AK7KCYffZc=;
        b=RiaYDqJsgFnOcEEV71+WCEd01kzdkDxItgknaiNFMf0IlUEB1qmhjvPd6lXVKWqFzr
         umKRR+RMGEvfkG/AAbxaWJo7OXKKRttJR4dXzKr75VNGDDOOGTZzWet1A9wRQkrxSRyh
         UtaLtfm9FIlkjtGyunl/uY9oxbUZyu+Ft05KJ0F/L6WXmOPPih5XGZxLr8MHqJ4lXtQq
         1bz2Q77tqDDC+ooFrBbRwHa/t1/fwd6sr+tA2k6jVagKw6yL4ePDMZh0ScTJmyuN6mGF
         r49Tt/VjcXnkZ8fmIBxyi8sAoH9xIB1RojkqW1IxsHuEHBJ2rKmISnzSSsvowcQiKK3y
         M8Og==
X-Gm-Message-State: AOAM530u3xYGGXuvl6OZnO5yGUNopiJv1mi2lo9xQe7PNhmEvFizHol0
        nCaufLbujIMdGBkmsYhsnMLMd0k1RRc=
X-Google-Smtp-Source: ABdhPJxqT5/F0ozull0+9niYgNc/Ek3neJ9ZV4dJU6xwV2FW0OGpz0cFE0V/5CuPF4LFmHYLF+vJUw==
X-Received: by 2002:a05:6e02:19cc:b0:2c6:6c59:4378 with SMTP id r12-20020a056e0219cc00b002c66c594378mr7117108ill.256.1646986462741;
        Fri, 11 Mar 2022 00:14:22 -0800 (PST)
Received: from james-x399.localdomain (97-118-243-247.hlrn.qwest.net. [97.118.243.247])
        by smtp.gmail.com with ESMTPSA id h16-20020a5e8410000000b006463d5a132asm3535078ioj.11.2022.03.11.00.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 00:14:22 -0800 (PST)
From:   James Hilliard <james.hilliard1@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH 1/1] uvcvideo: Unify UVC payload header parsing.
Date:   Fri, 11 Mar 2022 01:14:11 -0700
Message-Id: <20220311081411.3673476-1-james.hilliard1@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pawel Osciak <posciak@chromium.org>

Create a separate function for parsing UVC payload headers and extract code
from other functions into it. Store the parsed values in a header struct.

Signed-off-by: Pawel Osciak <posciak@chromium.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/media/usb/uvc/uvc_video.c | 263 +++++++++++++++---------------
 drivers/media/usb/uvc/uvcvideo.h  |  21 +++
 2 files changed, 152 insertions(+), 132 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 1b4cc934109e..672dc5f9cd2d 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -461,40 +461,14 @@ static inline ktime_t uvc_video_get_time(void)
 
 static void
 uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
-		       const u8 *data, int len)
+		       struct uvc_payload_header *header)
 {
 	struct uvc_clock_sample *sample;
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
 	unsigned long flags;
 	ktime_t time;
 	u16 host_sof;
 	u16 dev_sof;
 
-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
-	/* Check for invalid headers. */
-	if (len < header_size)
-		return;
-
 	/* Extract the timestamps:
 	 *
 	 * - store the frame PTS in the buffer structure
@@ -502,16 +476,16 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	 *   kernel timestamps and store them with the SCR STC and SOF fields
 	 *   in the ring buffer
 	 */
-	if (has_pts && buf != NULL)
-		buf->pts = get_unaligned_le32(&data[2]);
+	if (header->has_pts && buf != NULL)
+		buf->pts = header->pts;
 
-	if (!has_scr)
+	if (!header->has_scr)
 		return;
 
 	/* To limit the amount of data, drop SCRs with an SOF identical to the
 	 * previous one.
 	 */
-	dev_sof = get_unaligned_le16(&data[header_size - 2]);
+	dev_sof = header->sof;
 	if (dev_sof == stream->clock.last_sof)
 		return;
 
@@ -552,7 +526,7 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	spin_lock_irqsave(&stream->clock.lock, flags);
 
 	sample = &stream->clock.samples[stream->clock.head];
-	sample->dev_stc = get_unaligned_le32(&data[header_size - 6]);
+	sample->dev_stc = header->stc;
 	sample->dev_sof = dev_sof;
 	sample->host_sof = host_sof;
 	sample->host_time = time;
@@ -795,114 +769,73 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
  */
 
 static void uvc_video_stats_decode(struct uvc_streaming *stream,
-		const u8 *data, int len)
+		struct uvc_payload_header *header)
 {
-	unsigned int header_size;
-	bool has_pts = false;
-	bool has_scr = false;
-	u16 scr_sof;
-	u32 scr_stc;
-	u32 pts;
-
 	if (stream->stats.stream.nb_frames == 0 &&
 	    stream->stats.frame.nb_packets == 0)
 		stream->stats.stream.start_ts = ktime_get();
 
-	switch (data[1] & (UVC_STREAM_PTS | UVC_STREAM_SCR)) {
-	case UVC_STREAM_PTS | UVC_STREAM_SCR:
-		header_size = 12;
-		has_pts = true;
-		has_scr = true;
-		break;
-	case UVC_STREAM_PTS:
-		header_size = 6;
-		has_pts = true;
-		break;
-	case UVC_STREAM_SCR:
-		header_size = 8;
-		has_scr = true;
-		break;
-	default:
-		header_size = 2;
-		break;
-	}
-
-	/* Check for invalid headers. */
-	if (len < header_size || data[0] < header_size) {
-		stream->stats.frame.nb_invalid++;
-		return;
-	}
-
-	/* Extract the timestamps. */
-	if (has_pts)
-		pts = get_unaligned_le32(&data[2]);
-
-	if (has_scr) {
-		scr_stc = get_unaligned_le32(&data[header_size - 6]);
-		scr_sof = get_unaligned_le16(&data[header_size - 2]);
-	}
-
 	/* Is PTS constant through the whole frame ? */
-	if (has_pts && stream->stats.frame.nb_pts) {
-		if (stream->stats.frame.pts != pts) {
+	if (header->has_pts && stream->stats.frame.nb_pts) {
+		if (stream->stats.frame.pts != header->pts) {
 			stream->stats.frame.nb_pts_diffs++;
 			stream->stats.frame.last_pts_diff =
 				stream->stats.frame.nb_packets;
 		}
 	}
 
-	if (has_pts) {
+	if (header->has_pts) {
 		stream->stats.frame.nb_pts++;
-		stream->stats.frame.pts = pts;
+		stream->stats.frame.pts = header->pts;
 	}
 
 	/* Do all frames have a PTS in their first non-empty packet, or before
 	 * their first empty packet ?
 	 */
 	if (stream->stats.frame.size == 0) {
-		if (len > header_size)
-			stream->stats.frame.has_initial_pts = has_pts;
-		if (len == header_size && has_pts)
+		if (header->payload_size > 0)
+			stream->stats.frame.has_initial_pts = header->has_pts;
+		if (header->payload_size == 0 && header->has_pts)
 			stream->stats.frame.has_early_pts = true;
 	}
 
 	/* Do the SCR.STC and SCR.SOF fields vary through the frame ? */
-	if (has_scr && stream->stats.frame.nb_scr) {
-		if (stream->stats.frame.scr_stc != scr_stc)
+	if (header->has_scr && stream->stats.frame.nb_scr) {
+		if (stream->stats.frame.scr_stc != header->stc)
 			stream->stats.frame.nb_scr_diffs++;
 	}
 
-	if (has_scr) {
+	if (header->has_scr) {
 		/* Expand the SOF counter to 32 bits and store its value. */
 		if (stream->stats.stream.nb_frames > 0 ||
 		    stream->stats.frame.nb_scr > 0)
 			stream->stats.stream.scr_sof_count +=
-				(scr_sof - stream->stats.stream.scr_sof) % 2048;
-		stream->stats.stream.scr_sof = scr_sof;
+				(header->sof - stream->stats.stream.scr_sof) % 2048;
+		stream->stats.stream.scr_sof = header->sof;
 
 		stream->stats.frame.nb_scr++;
-		stream->stats.frame.scr_stc = scr_stc;
-		stream->stats.frame.scr_sof = scr_sof;
+		stream->stats.frame.scr_stc = header->stc;
+		stream->stats.frame.scr_sof = header->sof;
 
-		if (scr_sof < stream->stats.stream.min_sof)
-			stream->stats.stream.min_sof = scr_sof;
-		if (scr_sof > stream->stats.stream.max_sof)
-			stream->stats.stream.max_sof = scr_sof;
+		if (header->sof < stream->stats.stream.min_sof)
+			stream->stats.stream.min_sof = header->sof;
+		if (header->sof > stream->stats.stream.max_sof)
+			stream->stats.stream.max_sof = header->sof;
 	}
 
 	/* Record the first non-empty packet number. */
-	if (stream->stats.frame.size == 0 && len > header_size)
+	if (stream->stats.frame.size == 0 && header->payload_size > 0)
 		stream->stats.frame.first_data = stream->stats.frame.nb_packets;
 
 	/* Update the frame size. */
-	stream->stats.frame.size += len - header_size;
+	stream->stats.frame.size += header->payload_size;
 
 	/* Update the packets counters. */
 	stream->stats.frame.nb_packets++;
-	if (len <= header_size)
+	if (header->payload_size == 0)
 		stream->stats.frame.nb_empty++;
 
-	if (data[1] & UVC_STREAM_ERR)
+	if (header->has_err)
 		stream->stats.frame.nb_errors++;
 }
 
@@ -1035,21 +968,9 @@ static void uvc_video_stats_stop(struct uvc_streaming *stream)
  * uvc_video_decode_end will never be called with a NULL buffer.
  */
 static int uvc_video_decode_start(struct uvc_streaming *stream,
-		struct uvc_buffer *buf, const u8 *data, int len)
+		struct uvc_buffer *buf, struct uvc_payload_header *header)
 {
-	u8 fid;
-
-	/* Sanity checks:
-	 * - packet must be at least 2 bytes long
-	 * - bHeaderLength value must be at least 2 bytes (see above)
-	 * - bHeaderLength value can't be larger than the packet size.
-	 */
-	if (len < 2 || data[0] < 2 || data[0] > len) {
-		stream->stats.frame.nb_invalid++;
-		return -EINVAL;
-	}
-
-	fid = data[1] & UVC_STREAM_FID;
+	u8 fid = header->fid;
 
 	/* Increase the sequence number regardless of any buffer states, so
 	 * that discontinuous sequence numbers always indicate lost frames.
@@ -1060,8 +981,8 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_video_stats_update(stream);
 	}
 
-	uvc_video_clock_decode(stream, buf, data, len);
-	uvc_video_stats_decode(stream, data, len);
+	uvc_video_clock_decode(stream, buf, header);
+	uvc_video_stats_decode(stream, header);
 
 	/* Store the payload FID bit and return immediately when the buffer is
 	 * NULL.
@@ -1072,7 +993,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 	}
 
 	/* Mark the buffer as bad if the error bit is set. */
-	if (data[1] & UVC_STREAM_ERR) {
+	if (header->has_err) {
 		uvc_dbg(stream->dev, FRAME,
 			"Marking buffer as bad (error bit set)\n");
 		buf->error = 1;
@@ -1091,7 +1012,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 			uvc_dbg(stream->dev, FRAME,
 				"Dropping payload (out of sync)\n");
 			if ((stream->dev->quirks & UVC_QUIRK_STREAM_NO_FID) &&
-			    (data[1] & UVC_STREAM_EOF))
+			    (header->has_eof))
 				stream->last_fid ^= UVC_STREAM_FID;
 			return -ENODATA;
 		}
@@ -1128,7 +1049,7 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
 
 	stream->last_fid = fid;
 
-	return data[0];
+	return 0;
 }
 
 static inline enum dma_data_direction uvc_stream_dir(
@@ -1215,12 +1136,12 @@ static void uvc_video_decode_data(struct uvc_urb *uvc_urb,
 }
 
 static void uvc_video_decode_end(struct uvc_streaming *stream,
-		struct uvc_buffer *buf, const u8 *data, int len)
+		struct uvc_buffer *buf, struct uvc_payload_header *header)
 {
 	/* Mark the buffer as done if the EOF marker is set. */
-	if (data[1] & UVC_STREAM_EOF && buf->bytesused != 0) {
+	if (header->has_eof && buf->bytesused != 0) {
 		uvc_dbg(stream->dev, FRAME, "Frame complete (EOF found)\n");
-		if (data[0] == len)
+		if (header->payload_size == 0)
 			uvc_dbg(stream->dev, FRAME, "EOF in empty payload\n");
 		buf->state = UVC_BUF_STATE_READY;
 		if (stream->dev->quirks & UVC_QUIRK_STREAM_NO_FID)
@@ -1267,6 +1188,75 @@ static int uvc_video_encode_data(struct uvc_streaming *stream,
 	return nbytes;
 }
 
+static int uvc_video_parse_header(struct uvc_streaming *stream,
+		const __u8 *data, int len, struct uvc_payload_header *header)
+{
+	unsigned int off = 2;
+
+	/* Sanity checks:
+	 * - packet must be at least 2 bytes long
+	 * - bHeaderLength value must be at least 2 bytes (see above)
+	 */
+	if (len < 2 || len < data[0] || data[0] < 2 )
+		goto error;
+
+	header->length = 2; /* 1 byte of header length + 1 byte of BFH. */
+
+	header->has_sli = false;
+	header->has_eof = data[1] & UVC_STREAM_EOF;
+	header->has_pts = data[1] & UVC_STREAM_PTS;
+	header->has_scr = data[1] & UVC_STREAM_SCR;
+	header->has_err = data[1] & UVC_STREAM_ERR;
+
+	if (header->has_pts)
+		header->length += 4;
+
+	if (header->has_scr)
+		header->length += 6;
+
+	if (stream->cur_format->fcc == V4L2_PIX_FMT_VP8) {
+		/* VP8 payload has 2 additional bytes of BFH. */
+		header->length += 2;
+		off += 2;
+
+		/* SLI always present for VP8 simulcast (at the end of header),
+		 * allowed for VP8 non-simulcast.
+		 */
+		header->has_sli = data[1] & UVC_STREAM_EOH;
+		if (header->has_sli)
+			header->length += 2;
+	}
+
+	/* - bHeaderLength value can't be larger than the packet size. */
+	if (data[0] != header->length)
+		goto error;
+
+	/* PTS 4 bytes, STC 4 bytes, SOF 2 bytes. */
+	if (header->has_pts) {
+		header->pts = get_unaligned_le32(&data[off]);
+		off += 4;
+	}
+
+	if (header->has_scr) {
+		header->stc = get_unaligned_le32(&data[off]);
+		off += 4;
+		header->sof = get_unaligned_le16(&data[off]);
+		off += 2;
+	}
+
+	if (header->has_sli)
+		header->sli = get_unaligned_le16(&data[off]);
+
+	header->payload_size = len - header->length;
+	header->fid = data[1] & UVC_STREAM_FID;
+
+	return 0;
+
+error:
+	stream->stats.frame.nb_invalid++;
+	return -EINVAL;
+}
+
 /* ------------------------------------------------------------------------
  * Metadata
  */
@@ -1391,7 +1381,9 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 			struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
 {
 	struct urb *urb = uvc_urb->urb;
+	struct uvc_payload_header header;
 	struct uvc_streaming *stream = uvc_urb->stream;
+	unsigned int len;
 	u8 *mem;
 	int ret, i;
 
@@ -1406,11 +1398,15 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 			continue;
 		}
 
-		/* Decode the payload header. */
 		mem = urb->transfer_buffer + urb->iso_frame_desc[i].offset;
+		len = urb->iso_frame_desc[i].actual_length;
+
+		ret = uvc_video_parse_header(stream, mem, len, &header);
+		if (ret < 0)
+			continue;
+
 		do {
-			ret = uvc_video_decode_start(stream, buf, mem,
-				urb->iso_frame_desc[i].actual_length);
+			ret = uvc_video_decode_start(stream, buf, &header);
 			if (ret == -EAGAIN)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		} while (ret == -EAGAIN);
@@ -1421,12 +1417,11 @@ static void uvc_video_decode_isoc(struct uvc_urb *uvc_urb,
 		uvc_video_decode_meta(stream, meta_buf, mem, ret);
 
 		/* Decode the payload data. */
-		uvc_video_decode_data(uvc_urb, buf, mem + ret,
-			urb->iso_frame_desc[i].actual_length - ret);
+		uvc_video_decode_data(uvc_urb, buf, mem + header.length,
+			urb->iso_frame_desc[i].actual_length - header.length);
 
 		/* Process the header again. */
-		uvc_video_decode_end(stream, buf, mem,
-			urb->iso_frame_desc[i].actual_length);
+		uvc_video_decode_end(stream, buf, &header);
 
 		if (buf->state == UVC_BUF_STATE_READY)
 			uvc_video_next_buffers(stream, &buf, &meta_buf);
@@ -1437,6 +1432,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 			struct uvc_buffer *buf, struct uvc_buffer *meta_buf)
 {
 	struct urb *urb = uvc_urb->urb;
+	struct uvc_payload_header header;
 	struct uvc_streaming *stream = uvc_urb->stream;
 	u8 *mem;
 	int len, ret;
@@ -1456,8 +1452,12 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 	 * header.
 	 */
 	if (stream->bulk.header_size == 0 && !stream->bulk.skip_payload) {
+		ret = uvc_video_parse_header(stream, mem, len, &header);
+		if (ret < 0)
+			return;
+
 		do {
-			ret = uvc_video_decode_start(stream, buf, mem, len);
+			ret = uvc_video_decode_start(stream, buf, &header);
 			if (ret == -EAGAIN)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		} while (ret == -EAGAIN);
@@ -1466,13 +1466,13 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 		if (ret < 0 || buf == NULL) {
 			stream->bulk.skip_payload = 1;
 		} else {
-			memcpy(stream->bulk.header, mem, ret);
-			stream->bulk.header_size = ret;
+			memcpy(stream->bulk.header, mem, header.length);
+			stream->bulk.header_size = header.length;
 
 			uvc_video_decode_meta(stream, meta_buf, mem, ret);
 
-			mem += ret;
-			len -= ret;
+			mem += header.length;
+			len -= header.length;
 		}
 	}
 
@@ -1491,8 +1491,7 @@ static void uvc_video_decode_bulk(struct uvc_urb *uvc_urb,
 	if (urb->actual_length < urb->transfer_buffer_length ||
 	    stream->bulk.payload_size >= stream->bulk.max_payload_size) {
 		if (!stream->bulk.skip_payload && buf != NULL) {
-			uvc_video_decode_end(stream, buf, stream->bulk.header,
-				stream->bulk.payload_size);
+			uvc_video_decode_end(stream, buf, &header);
 			if (buf->state == UVC_BUF_STATE_READY)
 				uvc_video_next_buffers(stream, &buf, &meta_buf);
 		}
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index 143230b3275b..587d86f9eb14 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -566,6 +566,27 @@ struct uvc_urb {
 	struct work_struct work;
 };
 
+struct uvc_payload_header {
+	bool has_eof;
+
+	bool has_pts;
+	u32 pts;
+
+	bool has_scr;
+	u16 sof;
+	u32 stc;
+
+	bool has_sli;
+	u16 sli;
+
+	u8 fid;
+
+	bool has_err;
+
+	int length;
+	int payload_size;
+};
+
 struct uvc_streaming {
 	struct list_head list;
 	struct uvc_device *dev;
-- 
2.25.1

